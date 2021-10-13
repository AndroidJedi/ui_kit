import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/_ui_kit/theme/nb_theme/nb_theme.dart';

class AppIcon extends StatelessWidget {
  final AppIcons icon;
  final double size;
  final Color color;

  const AppIcon(this.icon, {Key? key, required this.size, required this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String i = describeEnum(icon).toLowerCase().replaceAll("_", "-");
    String path = 'assets/icon/ic_' + i + '.png';
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Image.asset(path, width: size, height: size, color: color, filterQuality: FilterQuality.high),
      ),
    );
  }
}
