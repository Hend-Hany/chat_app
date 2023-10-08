import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widget/snack_bar.dart';

import '../chats/view.dart';
import '../core/route_utils/route_utils.dart';

part 'state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() :super(LoginInit());

  String? email, password;

  Future<void> login() async {
    if (email == null || password == null) {
      return;
    }
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!,);
      if (credential.user?.uid != null) {
        RouteUtils.pushAndPopAll(ChatsView());
        return;
      }
      throw FirebaseAuthException(code: '0',message: null);
    }on FirebaseAuthException catch(e) {
      showSnackBar(e.message??'Something went wrong',isError:true);
    }
    emit(LoginInit());
  }

}