import 'package:flutter/material.dart';
import 'package:ui_kit/counter_card/model.dart';
import 'package:ui_kit/inner_card/inner_card_widget.dart';
import 'package:ui_kit/theme/nb_theme/mixins.dart';
import 'package:ui_kit/theme/nb_theme/nb_theme.dart';
import 'package:ui_kit/theme/service/dynamic_theme.dart';

class InnerScreen extends StatelessWidget with ScreenThemeMixin {
  static Route route() {
    return MaterialPageRoute(builder: (_) => const InnerScreen());
  }

  const InnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            color: DynamicTheme.getParam(themeValueRequest(NbTheme.keyColorBackground), context),
            child: Text('Inner Screen', style: DynamicTheme.textTitle(this, context))),
      ),
      body: InnerCardWidget(
        screenKey: getKey(),
        model: const InnerCardModel(title: 'You have pushed the button this many times:', counter: 0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: DynamicTheme.getParam(themeValueRequest(NbTheme.keyColorActionButton), context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  String getKey() => 'key_inner_screen';
}
