import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit/counter_card/model.dart';
import 'package:ui_kit/screen/inner_screen.dart';
import 'package:ui_kit/theme/service/dynamic_theme.dart';
import 'package:ui_kit/theme/nb_theme/mixins.dart';
import 'package:ui_kit/theme/nb_theme/nb_theme.dart';

import 'counter_card/counter_card_widget.dart';

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

class _MyHomePageState extends State<MyHomePage> with ScreenThemeMixin {
  int _counter = 0;
  late Future<NbTheme?> _themeFuture;

  @override
  void initState() {
    _themeFuture = _loadTheme();
    super.initState();
  }

  Future<NbTheme?> _loadTheme() async {
    try {
      final stringTheme = await rootBundle.loadString('config/nb_theme.json');
      final themeJson = json.decode(stringTheme);
      return NbTheme.fromJson(themeJson.first);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext c) {
    return FutureBuilder<NbTheme?>(
        future: _themeFuture,
        builder: (c1, snapshot) {
          if (snapshot.data != null) {
            return DynamicThemeService(
                initialTheme: snapshot.data!,
                child: Builder(builder: (c2) {
                  return MaterialApp(
                    navigatorKey: navigator,
                    home: Scaffold(
                      appBar: AppBar(
                        title: Container(
                            color: DynamicTheme.getParam(themeValueRequest(NbTheme.keyColorBackground), c2),
                            child: Text(widget.title, style: DynamicTheme.textTitle(this, c2))),
                      ),
                      body: CounterCardWidget(
                        screenKey: getKey(),
                        model: InnerCardModel(title: 'You have pushed the button this many times:', counter: _counter),
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          Navigator.of(navigator.currentContext!).push<void>(InnerScreen.route());
                        },
                        backgroundColor: DynamicTheme.getParam(themeValueRequest(NbTheme.keyColorActionButton), c2),
                        tooltip: 'Increment',
                        child: const Icon(Icons.add),
                      ),
                    ),
                  );
                }));
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  String getKey() => "main_screen";
}

final navigator = GlobalKey<NavigatorState>();
