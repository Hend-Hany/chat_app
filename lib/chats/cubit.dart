import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/models/user.dart'as User;

part 'state.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() :super(ChatsInit());

  List<User.User>users=[];

  Future<void> getUser() async {
    emit(ChatsLoading());
    try {
      final result = await FirebaseFirestore.instance
          .collection('users').get();
      for(var i in result.docs){
        if (i.data()['uid']==FirebaseAuth.instance.currentUser?.uid) {
          continue;
        }
        users.add(User.User.fromJson(i.data()));
      }
    }catch(e) {
      print(e);
    }
    emit(ChatsInit());
  }

}