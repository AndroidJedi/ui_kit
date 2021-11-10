import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '_ui_kit/theme/nb_theme/nb_theme.dart';
import '_ui_kit/theme/service/dynamic_theme.dart';
import 'data_delegate/data_delegate.dart';

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
  late DataDelegate<int> dataDelegate;
  static Random random = Random();
  StreamSubscription? s1;
  StreamSubscription? s2;
  StreamSubscription? s3;

  int? cache = 1;

  Future<int?> getFromCache() async {
    print('getFromCache: $cache');
    return cache;
  }

  Future<int?> putToCache(int? v) async {
    cache = v;
    print('putToCache: $cache');
    return cache;
  }

  Future<int?> getFromRemote(String fooRequest) async {
    int remote = random.nextInt(3);
    print('getFromRemote: $remote');
    return remote;
  }

  @override
  void initState() {
    dataDelegate = DataDelegate(
      getFromCache: (request) => getFromCache(request),
      getFromRemote: (request) => getFromRemote(request),
      putToCache: (v) => putToCache(v),
    );
    super.initState();
  }

  @override
  void dispose() {
    dataDelegate.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicThemeService(
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
                      if (s1 != null) {
                        await s1?.cancel();
                      }
                      s1 = dataDelegate.observe(false).listen((event) {
                        print("Subscriber 1: $event");
                      });
                    },
                    child: Text('Add Subscriber 1. force = false')),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () async {
                      if (s2 != null) {
                        await s2?.cancel();
                      }
                      s2 = dataDelegate.observe(true).listen((event) {
                        print("Subscriber 2: $event");
                      });
                    },
                    child: Text('Add Subscriber 2. force = true')),
                SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () async {
                      if (s3 != null) {
                        await s3?.cancel();
                      }
                      s3 = dataDelegate.observe(false).listen((event) {
                        print("Subscriber 3: $event");
                      });
                    },
                    child: Text('Add Subscriber 3.  force = false')),
              ],
            ),
          ),
        );
      }),
    );
  }
}

final navigator = GlobalKey<NavigatorState>();
