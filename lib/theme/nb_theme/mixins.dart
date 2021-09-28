import 'package:ui_kit/theme/nb_theme/nb_theme.dart';

mixin ThemeMixin {
  ThemeValueRequest themeValueRequest(String valueKey);
}

mixin CardThemeMixin implements ThemeMixin {
  String getKey();

  String parentKey();

  @override
  ThemeValueRequest themeValueRequest(String valueKey) {
    return ThemeValueRequest(valueKey: valueKey, screenKey: parentKey(), cardKey: getKey());
  }
}

mixin ScreenThemeMixin implements ThemeMixin {
  String getKey();

  @override
  ThemeValueRequest themeValueRequest(String valueKey) {
    return ThemeValueRequest(valueKey: valueKey, screenKey: getKey(), cardKey: null);
  }
}
