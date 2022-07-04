import 'package:chatapp/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy('CreatedAt', descending: true)
          .snapshots(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data.docs;
        return ListView.builder(
            itemCount: docs.length,
            reverse: true,
            itemBuilder: (ctx, index) => MessageBubble(
                  docs[index]['message'],
                  docs[index]['username'],
                  docs[index]['imageUrl'],
                  docs[index]['userId'] ==
                      FirebaseAuth.instance.currentUser.uid,
                  key: ValueKey(docs[index]),
                ));
      },
    );
  }
}
