import 'package:flutter/material.dart';
import 'package:chat_app/core/route_utils/route_utils.dart';

void showSnackBar (String message,{bool isError=false}){
  ScaffoldMessenger.of(RouteUtils.context).hideCurrentSnackBar();
  ScaffoldMessenger.of(RouteUtils.context).showSnackBar(SnackBar(
     content: Text(message),
    backgroundColor: isError?Colors.red:null,
  ));
}