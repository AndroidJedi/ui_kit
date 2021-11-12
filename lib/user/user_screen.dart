import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/data_delegate/repository.dart';
import 'package:ui_kit/user/user_cubit.dart';

import '../main.dart';

class UserScreen extends StatelessWidget {
  static Route route(int screenCount) {
    return MaterialPageRoute(builder: (_) => UserScreen(screenCount: screenCount));
  }

  final int screenCount;

  const UserScreen({required this.screenCount, Key? key}) : super(key: key);

  static final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(context.read<UserRepositoryImpl>(), Initial()),
      child: Builder(builder: (context) {
        return BlocBuilder<UserCubit, UserState>(
            bloc: context.read<UserCubit>(),
            builder: (context, state) {
              if (state is Loading) {
                return const Text('Loading..');
              } else if (state is UserFetched) {
                return Container(
                  color: Colors.green,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(child: Text(state.user.email)),
                      ElevatedButton(
                          onPressed: () async {
                            navigator.currentState!.push(UserScreen.route(screenCount + 1));
                          },
                          child: const Text('Launch UserScreen')),
                    ],
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          context
                              .read<UserCubit>()
                              .getUser(request: UserRequest(email: _getRandomEmail()), force: screenCount % 2 == 0);
                        },
                        child: const Text('Get User')),
                  ],
                );
              }
            });
      }),
    );
  }

  String _getRandomEmail() => remoteUsers[_random.nextInt(remoteUsers.length - 1)].email;
}
