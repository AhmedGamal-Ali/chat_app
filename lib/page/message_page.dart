import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/cubit/chat_cubit/chat_cubit.dart';
import '../custom_widget/bubble_chat.dart';
import '../constant/constant.dart';
import '../model/message_model.dart';

class MessagePage extends StatelessWidget {
  static String id = "messagepage";
  TextEditingController controller = TextEditingController();
  ScrollController scrolController = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Message> messageList = BlocProvider.of<ChatCubit>(context).messageList;
    var email = ModalRoute.of(context)!.settings.arguments ;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(kLoge, height: 50), Text("Scolar")],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                return ListView.builder(
                    reverse: true,
                    controller: scrolController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].email == email
                          ? BubbleChat(message: messageList[index])
                          : BubbleChatForFriend(message: messageList[index]);
                    });
              },
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
            child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context).sendMessage(data, email.toString());
                  controller.clear();
                  scrolController.animateTo(0,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut);
                },
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                  hintText: "Message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                )),
          )
        ],
      ),
    );
  }
}
