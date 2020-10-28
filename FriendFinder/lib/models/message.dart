import 'package:friendfinder/models/user.dart';

class Message{
  int messageId;
  DateTime timeStamp;
  String sender;
  String reciever;
  bool status;
  String message;

  Message({
    this.message,
    this.timeStamp,
    this.sender,
    this.reciever,
    this.status,

  });

  void sendMessage(){
    
  }
  void deleteMessage(){

  }

}