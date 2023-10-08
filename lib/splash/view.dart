import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/chats/view.dart';
import 'package:chat_app/core/route_utils/route_utils.dart';
import 'package:chat_app/login/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      final currentUser=FirebaseAuth.instance.currentUser;
      RouteUtils.pushAndPopAll(currentUser==null?LoginView():ChatsView());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.comment,
          size: 200,
        ),
      ),
    );
  }
}
