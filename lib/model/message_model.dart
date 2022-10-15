import '../constant/constant.dart';

class Message {
  Message(this.message, this.email);

  String message;
  String email;

  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData["id"]);
  }
}
