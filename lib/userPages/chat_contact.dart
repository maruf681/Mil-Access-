import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/userPages/inbox.dart';

class ChatContactListScreen extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> contactsList;
  ChatContactListScreen({Key? key})
    : contactsList = fetchUsersWithRoleUser(),
      super(key: key);
  static Future<List<Map<String, dynamic>>> fetchUsersWithRoleUser() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user') // assuming your users collection is called 'users'
        .where('role', isEqualTo: 'User') // filter by role
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
                subtitle: Text(contact['unitName']!),
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
