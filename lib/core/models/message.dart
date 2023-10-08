import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String uid;
  final String message;
  final Timestamp time;

  Message({
    required this.uid,
    required this.message,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      uid: json['uid'],
      message: json['message'],
      time: json['time'],
    );
  }
  Map<String,dynamic>toJson(){
    return {
      'message':message,
      'uid':uid,
      'time':time,
    };
}
}
