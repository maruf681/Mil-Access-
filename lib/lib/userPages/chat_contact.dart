import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_data.dart';
import 'package:flutter_application_1/userPages/chat_inbox.dart';

class ChatContactListScreen extends StatefulWidget {
  const ChatContactListScreen({Key? key}) : super(key: key);

  @override
  _ChatContactListScreenState createState() => _ChatContactListScreenState();
}

class _ChatContactListScreenState extends State<ChatContactListScreen> {
  late Future<List<Map<String, dynamic>>> contactsList;
  final Map<String, int> unreadCount = {};
  StreamSubscription<QuerySnapshot>? _contacts;
  @override
  void initState() {
    super.initState();
    // final id = 'BB7JJHQ9gufIsTYJrU9OBZx9BcU2_cYsuUIPhGOduA9EANPszXgTXx7o2';
    contactsList = fetchUsersWithRoleUser();
    _contacts = FirebaseFirestore.instance
        .collection('chat')
        .where('members', arrayContains: UserData.uid)
        .snapshots()
        .listen((unreadSnapshot) {
          if (unreadSnapshot.docs.isNotEmpty) {
            for (var doc in unreadSnapshot.docs) {
              // if (change.type == DocumentChangeType.added) {
              final chatId = doc.id;
              setState(() {
                unreadCount[chatId] = doc.data()['unread_${UserData.uid}'] ?? 0;
              });
            }
            //}
          }
        });
  }

  @override
  void dispose() {
    _contacts!.cancel();
    super.dispose();
  }

  static Future<List<Map<String, dynamic>>> fetchUsersWithRoleUser() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('role', isEqualTo: 'User')
        .where('uid', isNotEqualTo: UserData.uid)
        .orderBy('uid')
        .get();

    // Extract docs data into a list
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  String getChatId(String userId) {
    final ids = [userId, FirebaseAuth.instance.currentUser?.uid];
    ids.sort();
    return ids.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Inbox'),
        //backgroundColor: Colors.blue[900],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: contactsList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found'));
          }
          final contacts = snapshot.data!;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    contact['profilePicture'] ??
                        'https://cdn-icons-png.flaticon.com/512/5436/5436245.png',
                  ),
                ),
                title: Text(
                  contact['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle:
                    unreadCount[getChatId(contact['uid'])] != null &&
                        unreadCount[getChatId(contact['uid'])]! > 0
                    ? Text(
                        '${unreadCount[getChatId(contact['uid'])]} new message(s)',
                        style: const TextStyle(color: Colors.red),
                      )
                    : Text(contact['unitName']!),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatInboxScreen(
                        contactName: contact['name'] ?? 'unknown',
                        chatId: getChatId(contact['uid']),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
