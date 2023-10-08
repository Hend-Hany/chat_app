import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/route_utils/route_utils.dart';
import 'package:chat_app/login/cubit.dart';
import 'package:chat_app/register/view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<LoginCubit>(context);
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Icon(
                  Icons.door_front_door_outlined,
                  size: 60,
                ),
                Text(
                  "Login",
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) => cubit.email = value,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  onChanged: (value) => cubit.password = value,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<LoginCubit, LoginStates>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: cubit.login,
                        child: Text('Login'),
                      );
                    }),
                TextButton(
                  onPressed:()=> RouteUtils.push(RegisterView()),
                  child: Text(
                    'Register',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
