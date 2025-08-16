import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class ChatInboxScreen extends StatefulWidget {
  final String contactName;
  final String chatId;
  const ChatInboxScreen({
    Key? key,
    required this.contactName,
    required this.chatId,
  }) : super(key: key);

  @override
  _ChatInboxScreenState createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  StreamSubscription<QuerySnapshot>? _messageListener;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> messages = [];
  DocumentSnapshot? lastFetchedDoc;
  bool onOpen = true;
  bool isLoading = false;
  String replyText = '';
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _replyToMessage(String messageContent) {
    setState(() {
      // Store the message content to show in the reply input field
      replyText = messageContent;
    });

    // Optionally, scroll to the input field or show a reply UI
    print('Replying to: $messageContent');
  }

  Future<void> seenMessages() async {
    try {
      FirebaseFirestore.instance.collection('chat').doc(widget.chatId).set({
        'unread_${UserData.uid}': 0,
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(message: e.toString());
    }
  }

  Future<void> storeMessages(String reply) async {
    final message = _messageController.text.trim();
    final members = widget.chatId.split('_');
    final receiverId = members.firstWhere((id) => id != UserData.uid);
    if (message.isEmpty) {
      return;
    }
    setState(() {
      replyText = ''; // Clear the reply text
    });
    final newChat = {
      'senderId': FirebaseAuth.instance.currentUser?.uid,
      'replyTo': reply,
      'content': message,
      'createdAt': FieldValue.serverTimestamp(),
    };
    _messageController.clear();
    try {
      final chatRef = FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.chatId);
      final messageDoc = chatRef.collection('messages').doc();
      await messageDoc.set(newChat);
      await chatRef.set(
        {'members': members, 'unread_$receiverId': FieldValue.increment(1)},
        SetOptions(merge: true),
      ); // merge: true so it won't overwrite other fields

      _scrollToBottom();
    } on FirebaseException {
      if (!mounted) return;
      context.showErrorSnackBar(message: 'Network error');
    }
  }

  Future<void> fetchOlderMessages() async {
    try {
      setState(() {
        isLoading = true;
      });
      Query messageColl = FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.chatId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .limit(10);
      if (lastFetchedDoc != null) {
        messageColl = messageColl.startAfterDocument(lastFetchedDoc!);
      }
      final querySnapShot = await messageColl.get();
      if (querySnapShot.docs.isNotEmpty) {
        lastFetchedDoc = querySnapShot.docs.last;
        messages.addAll(querySnapShot.docs);
        setState(() {});
      }
    } on FirebaseException catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(message: e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // If we are near the top (adjust threshold as needed)
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent + 10) {
        fetchOlderMessages();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await seenMessages();
      await fetchOlderMessages();
      _messageListener = FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.chatId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) async {
            if (snapshot.docs.isNotEmpty) {
              if (onOpen) {
                _scrollToBottom();
                onOpen = false;
                return;
              }
              final newMsg = snapshot.docs.first;
              lastFetchedDoc = snapshot.docs.first;
              if (messages.isEmpty || newMsg.id != messages.first.id) {
                setState(() {
                  messages.insert(0, newMsg);
                });
              }
            }
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
            await seenMessages();
          });
    });
  }

  @override
  void dispose() {
    _messageListener!.cancel();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.network(
              'https://cdn-icons-png.flaticon.com/512/5436/5436245.png',
              height: 35,
              width: 35,
            ),
          ),
        ],
        title: Text(
          widget.contactName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          isLoading
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white, // background circle
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.green[700], // your theme color
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                index = messages.length - 1 - index;
                final message = messages[index];
                final data = message.data() as Map<String, dynamic>?;
                final isCurrentUser = message['senderId'] == UserData.uid;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: isCurrentUser
                        ? MainAxisAlignment
                              .end // Align sender's bubble and button to the right
                        : MainAxisAlignment
                              .start, // Align receiver's bubble and button to the left
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // if (isCurrentUser) // Share button for receiver (on the right of the bubble)
                      //   TextButton(
                      //     style: TextButton.styleFrom(
                      //       padding: EdgeInsets.zero, // removes all padding
                      //       minimumSize: const Size(
                      //         0,
                      //         0,
                      //       ), // prevents minimum size constraints
                      //       tapTargetSize: MaterialTapTargetSize
                      //           .shrinkWrap, // shrinks touch target
                      //     ),
                      //     onPressed: () {
                      //       // Handle share action
                      //     },
                      //     child: const Icon(Icons.reply, color: Colors.blue),
                      //   ),
                      ChatBubble(
                        clipper: ChatBubbleClipper1(
                          type: isCurrentUser
                              ? BubbleType.sendBubble
                              : BubbleType.receiverBubble,
                        ),
                        alignment: isCurrentUser
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 20),
                        backGroundColor: isCurrentUser
                            ? Colors.grey
                            : Colors.blue,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data != null &&
                                  data.containsKey('replyTo') &&
                                  data['replyTo'] != null &&
                                  data['replyTo'].toString().isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.only(bottom: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    message['replyTo'],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              Text(
                                message['content'],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (!isCurrentUser) // Share button for sender (on the left of the bubble)
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // removes all padding
                            minimumSize: const Size(
                              0,
                              0,
                            ), // prevents minimum size constraints
                            tapTargetSize: MaterialTapTargetSize
                                .shrinkWrap, // shrinks touch target
                          ),
                          onPressed: () {
                            _replyToMessage(message['content']);
                          },
                          child: const Icon(Icons.reply, color: Colors.blue),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Reply UI (conditionally displayed)
          if (replyText.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Replying to: $replyText',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        replyText = ''; // Clear the reply text
                      });
                    },
                  ),
                ],
              ),
            ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => storeMessages(replyText),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                    backgroundColor: Colors.green[700],
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
