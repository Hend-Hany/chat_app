import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/models/message.dart';
import '../core/models/user.dart' as User;

part 'state.dart';

class ChatsDetailsCubit extends Cubit<ChatsDetailsStates> {
  ChatsDetailsCubit({required this.user}) : super(ChatsDetailsInit());

  final User.User user;

  List<Message> messages = [];
  TextEditingController textEditingController = TextEditingController();
  StreamSubscription? messagesStream;

  Future<void> getMessage() async {
    emit(ChatsDetailsLoading());
    final uid = FirebaseAuth.instance.currentUser!.uid;
    messagesStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(uid)
        .collection(user.uid)
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      messages.clear();
      for (var i in event.docs) {
        messages.add(Message.fromJson(i.data()));
      }
      emit(ChatsDetailsInit());
    });
  }

  Future<void> sendMessage() async {
    final text = textEditingController.text;
    if (text.trim().isEmpty || text.trim().length == 0) {
      return;
    }
    textEditingController.clear();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final message = Message(
        uid: uid,
        message: text,
        time: Timestamp.now(),
    );
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(uid)
        .collection(user.uid)
        .doc()
        .set(message.toJson());
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(user.uid)
        .collection(uid)
        .doc()
        .set(message.toJson());
      emit(ChatsDetailsInit());
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    messagesStream?.cancel();
    return super.close();
  }
}
