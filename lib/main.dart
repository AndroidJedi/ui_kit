import 'package:flutter/material.dart';

import '_ui_kit/theme/nb_theme/nb_theme.dart';
import '_ui_kit/theme/service/dynamic_theme.dart';
import '_ui_kit/ui_kit.dart';

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
    return DynamicThemeService(
      initialTheme: NbTheme.defaultTheme,
      child: Builder(builder: (c2) {
        return MaterialApp(
          navigatorKey: navigator,
          home: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiKit.buttonCtaPrimary(label: "Label", context: c2, onTap: () {}),
                UiKit.spaceVertSm,
                UiKit.buttonCtaPrimary(label: "Label", context: c2),
                UiKit.spaceVertSm,
                UiKit.buttonCtaSecondary(label: "Label", context: c2, onTap: () {}),
                UiKit.spaceVertSm,
                UiKit.buttonCtaSecondary(label: "Label", context: c2),
                UiKit.spaceVertSm,
                UiKit.buttonIconCtaPrimary(label: "Label", context: c2, onTap: () {}),
              ],
            ),
          ),
        );
      }),
    );
  }
}

final navigator = GlobalKey<NavigatorState>();
