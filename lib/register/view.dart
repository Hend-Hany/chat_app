import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/core/route_utils/route_utils.dart';
import 'package:chat_app/register/cubit.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<RegisterCubit>(context);
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                Icon(
                  Icons.door_front_door_outlined,
                  size: 60,
                ),
                Text(
                  "Register",
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
                BlocBuilder<RegisterCubit, RegisterStates>(
                    builder: (context, state) {
                  if (state is RegisterLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: cubit.register,
                    child: Text('Register'),
                  );
                }),
                TextButton(
                  onPressed: RouteUtils.pop,
                  child: Text(
                    'Login',
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
