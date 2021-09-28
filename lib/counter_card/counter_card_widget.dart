import 'package:flutter/material.dart';
import 'package:ui_kit/counter_card/model.dart';
import 'package:ui_kit/theme/service/dynamic_theme.dart';
import 'package:ui_kit/theme/nb_theme/mixins.dart';
import 'package:ui_kit/theme/nb_theme/nb_theme.dart';

class CounterCardWidget extends StatelessWidget with CardThemeMixin {
  final CounterCardModel model;
  final String screenKey;

  const CounterCardWidget({required this.model, required this.screenKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DynamicTheme.getParam(themeValueRequest(NbTheme.keyColorBackground), context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(model.title, style: DynamicTheme.textBody(this, context)),
            Text('${model.counter}', style: DynamicTheme.textTitle(this, context)),
          ],
        ),
      ),
    );
  }

  @override
  String getKey() => 'id_counter_card';

  @override
  String parentKey() => screenKey;
}
