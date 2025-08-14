import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/widgets/snackbar.dart';
import 'package:intl/intl.dart';

class ChatInboxScreen extends StatefulWidget {
  final String contactName;
  final chatId;
  const ChatInboxScreen({
    Key? key,
    required this.contactName,
    required this.chatId,
  }) : super(key: key);

  @override
  _ChatInboxScreenState createState() => _ChatInboxScreenState();
}

class _ChatInboxScreenState extends State<ChatInboxScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> storeMessages() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      return;
    }
    final newChat = {
      'senderId': FirebaseAuth.instance.currentUser?.uid,
      'content': message,
      'createdAt': FieldValue.serverTimestamp(),
    };
    _messageController.clear();
    try {
      final messageDoc = FirebaseFirestore.instance
          .collection('chat')
          .doc(widget.chatId)
          .collection('messages')
          .doc();
      await messageDoc.set(newChat);
      _scrollToBottom();
    } on FirebaseException catch (e) {
      if (!mounted) return;
      context.showErrorSnackBar(message: 'Network error');
    }
  }

  // Future<void> fetchMessages() async {
  //   _messageController.clear();
  //   try {
  //     final messageColl = FirebaseFirestore.instance
  //         .collection('chat')
  //         .doc(widget.chatId)
  //         .collection('messages');
  //     final querySnapShot = await messageColl
  //         .orderBy('createdAt', descending: false)
  //         .get();
  //     if (querySnapShot.docs.isNotEmpty) {
  //       final oldChats = querySnapShot.docs.map((doc) => doc.data()).toList();
  //       setState(() {
  //         _messages = List<Map<String, dynamic>>.from(oldChats);
  //       });
  //     }
  //   } on FirebaseException catch (e) {
  //     if (!mounted) return;
  //     context.showErrorSnackBar(message: e.toString());
  //   }
  // }

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await fetchMessages();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contactName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green[700],
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No messages yet.'));
                }

                final messages = snapshot.data!.docs;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isCurrentUser = message['senderId'] == UserData.uid;

                    // Extract and format the timestamp
                    final timestamp = message['createdAt']?.toDate();
                    final formattedDate = timestamp != null
                        ? DateFormat('hh:mm a').format(timestamp)
                        : 'Unknown time';

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: isCurrentUser
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          // Display the formatted date and time above the message
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ), // Space between date and message
                          Row(
                            mainAxisAlignment: isCurrentUser
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (!isCurrentUser) // Show profile picture for other users
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://cdn-icons-png.flaticon.com/512/5436/5436245.png',
                                  ),
                                  radius: 20,
                                ),
                              const SizedBox(
                                width: 8,
                              ), // Space between avatar and message
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: isCurrentUser
                                      ? Colors.grey[300]
                                      : Colors.blue[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message['content'],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
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
                  onPressed: storeMessages,
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
