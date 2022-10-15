import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../model/message_model.dart';

class BubbleChat extends StatelessWidget {
  BubbleChat({required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.only(left: 16, top: 22, right: 16, bottom: 22),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        child: (Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}

class BubbleChatForFriend extends StatelessWidget {
  BubbleChatForFriend({required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.only(left: 16, top: 22, right: 16, bottom: 22),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        child: (Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
          ),
        )),
      ),
    );
  }
}
