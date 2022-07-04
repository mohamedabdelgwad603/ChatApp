import 'dart:io';

import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final bool isMe;
  final String username;
  final String message;
  final String imageurl;

  MessageBubble(this.message, this.username, this.imageurl, this.isMe,
      {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        mainAxisAlignment:
            !isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: !isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                  bottomLeft: isMe ? Radius.circular(0) : Radius.circular(14),
                  bottomRight: !isMe ? Radius.circular(0) : Radius.circular(14),
                )),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Column(
              crossAxisAlignment:
                  !isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline6.color),
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: !isMe
                        ? Colors.black
                        : Theme.of(context).accentTextTheme.headline6.color,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      Positioned(
        child: CircleAvatar(backgroundImage: NetworkImage(imageurl)),
        top: 0,
        left: isMe ? 120 : null,
        right: !isMe ? 120 : null,
      ),
    ]);
  }
}
