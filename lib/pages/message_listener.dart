import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageListener extends StatefulWidget {
  final String userId;

  const MessageListener({Key? key, required this.userId}) : super(key: key);

  @override
  _MessageListenerState createState() => _MessageListenerState();
}

class _MessageListenerState extends State<MessageListener> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    print('User ID: ${widget.userId}'); // Print the userId

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: _firestore.collection('messages').doc(widget.userId).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>?;
              final messages = userData?['messages'] as List<dynamic>? ?? [];

              return Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index] as String;
                    return ListTile(
                      title: Text(message),
                    );
                  },
                ),
              );
            },
          ),
          Text('User ID: ${widget.userId}'), // Display the userId

        ],

      ),


    );
  }
}