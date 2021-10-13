import 'package:flutter/material.dart';

import '../nb_theme/nb_theme.dart';

class DynamicTheme extends InheritedWidget {
  final _DynamicThemeServiceState state;

  const DynamicTheme({required Widget child, required this.state, Key? key}) : super(child: child, key: key);

  @override
  bool updateShouldNotify(DynamicTheme oldWidget) => this != oldWidget;

  void setTheme(NbTheme theme) {
    state.setTheme(theme);
  }

  NbTheme getTheme() {
    return state.theme;
  }

  static DynamicTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DynamicTheme>()!;
  }
}

class DynamicThemeService extends StatefulWidget {
  final Widget child;
  final NbTheme initialTheme;

  const DynamicThemeService({required this.child, required this.initialTheme, Key? key}) : super(key: key);

  @override
  _DynamicThemeServiceState createState() => _DynamicThemeServiceState();
}

class _DynamicThemeServiceState extends State<DynamicThemeService> {
  late NbTheme theme;

  void setTheme(NbTheme theme) {
    setState(() {
      this.theme = theme;
    });
  }

  @override
  void initState() {
    theme = widget.initialTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      child: widget.child,
      state: this,
    );
  }
}