import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/model/message_model.dart';

import '../../constant/constant.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messageList=[];
  sendMessage(String data , String email){
    messages.add({
      kMessage: data,
      kCreeatAt: DateTime.now(),
      "id": email,
    });
  }
  reciveMessage(){
    messages.orderBy(kCreeatAt, descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs){
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messageList: messageList));
    });
  }
}
