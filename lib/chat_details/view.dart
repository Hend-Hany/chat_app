import 'package:chat_app/chat_details/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/models/user.dart' as User;

class ChatsDetailsView extends StatelessWidget {
  const ChatsDetailsView({Key? key, required this.user}) : super(key: key);

  final User.User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>ChatsDetailsCubit(user: user)..getMessage(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(user.email),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: BlocBuilder<ChatsDetailsCubit,ChatsDetailsStates>(
            builder: (context,state){
              if (state is ChatsDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final cubit =BlocProvider.of<ChatsDetailsCubit>(context);
              final messages =cubit.messages;
              return Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context,index){
                            final message=messages[index];
                            final isMe =message.uid==FirebaseAuth.instance.currentUser?.uid;
                            return Row(
                              mainAxisAlignment: isMe?MainAxisAlignment.end:MainAxisAlignment.start,
                              children: [
                                UnconstrainedBox(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 300,
                                      maxWidth: 10
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 12),
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        message.message,
                                        style: TextStyle(
                                          color: isMe?null:Colors.white,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: isMe? Colors.grey:Colors.blue
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                      ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    children: [
                      Expanded(
                          child:TextFormField(
                            controller: cubit.textEditingController,
                            textInputAction: TextInputAction.send,
                            decoration: InputDecoration(
                              hintText: 'Message...',
                            ),
                          ),
                      ),
                      SizedBox(width: 12,),
                      InkWell(
                        onTap: cubit.sendMessage,
                        child: Icon(
                          Icons.send
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24,),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
