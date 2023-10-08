import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widget/snack_bar.dart';

import '../chats/view.dart';
import '../core/route_utils/route_utils.dart';

part 'state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() :super(RegisterInit());

  String? email, password;

  Future<void> register() async {
    if (email == null || password == null) {
      return;
    }
    emit(RegisterLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!,);
      if (credential.user?.uid != null) {
        await setUserData(credential.user!.uid);
        RouteUtils.pushAndPopAll(ChatsView());
        return;
      }
    }on FirebaseAuthException catch(e) {
      showSnackBar(e.message??'Something went wrong',isError:true);
    }
    emit(RegisterInit());
  }

  Future<void> setUserData(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'email': email,
          'uid': uid,
        });
  }
}