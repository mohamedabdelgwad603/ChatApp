import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String textValue = "";
  var _controller = TextEditingController();
  _sendmessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'message': textValue,
      'CreatedAt': Timestamp.now(),
      'username': userdata['username'],
      'userId': user.uid,
      'imageUrl': userdata['image_url']
    });
    _controller.clear();
    setState(() {
      textValue = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(hintText: "send message"),
            onChanged: (val) {
              setState(() {
                textValue = val;
              });
            },
            controller: _controller,
          ),
        ),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send),
          onPressed: textValue.trim().isEmpty ? null : _sendmessage,
        )
      ],
    );
  }
}
