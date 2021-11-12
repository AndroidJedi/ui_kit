import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/data_delegate/repository.dart';
import 'package:ui_kit/user/user_screen.dart';
import '_ui_kit/theme/nb_theme/nb_theme.dart';
import '_ui_kit/theme/service/dynamic_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepositoryImpl>(
      create: (context) => UserRepositoryImpl(localSource: LocalUserDataSource(), remoteSource: RemoteUserDataSource()),
      child: DynamicThemeService(
        initialTheme: NbTheme.defaultTheme,
        child: Builder(builder: (c2) {
          return MaterialApp(
            navigatorKey: navigator,
            home: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        navigator.currentState!.push(UserScreen.route(1));
                      },
                      child: const Text('Launch UserScreen')),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

final navigator = GlobalKey<NavigatorState>();
