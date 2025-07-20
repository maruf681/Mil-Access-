import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: const Center(
        child: Text(
          "Chat feature under construction!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
