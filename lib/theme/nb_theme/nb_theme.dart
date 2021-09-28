import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/theme/nb_theme/theme_json_value.dart';

class NbTheme {
  static const keyTheme = "key";
  static const keyColorPrimary = "primary_color";
  static const keyColorSecondary = "secondary_color";
  static const keyColorNavigation = "navigation_color";
  static const keyColorBackground = "background_color";
  static const keyColorScreenBackground = "screen_background_color";
  static const keyColorScreenSecondaryBackground = "screen_secondary_background_color";
  static const keyColorCardBackground = "card_background_color";
  static const keyColorCardSecondaryBackground = "card_secondary_background_color";
  static const keyColorIconLabel = "icon_label_color";
  static const keyColorButtonPrimary = "button_primary_color";
  static const keyColorButtonSecondary = "button_secondary_color";
  static const keyColorButtonDisabled = "button_disabled_color";
  static const keyColorPrimaryText = "primary_text_color";
  static const keyColorSecondaryText = "secondary_text_color";
  static const keyColorTertiaryText = "tertiary_text_color";
  static const keyColorActionButton = "action_button_color";
  static const keyColorHighlightPrimary = "highlight_primary_color";
  static const keyColorHighlightSecondary = "highlight_secondary_color";
  static const keyColorTabBar = "tab_bar_color";

  static const keySizeLogo = "logo_size";
  static const keyFontFamily = "font_family";

  static const keyOverridesScreen = "screen_overrides";
  static const keyOverridesCard = "card_overrides";
  static const keyStatusBarStyle = "status_bar_style";

  final Map<String, dynamic> _attrs = {};

  ///Chain of responsibility. First chained JsonValue has highest priority
  final JsonValue _jsonValueChain = CardJsonValue()
      .setNext(ScreenJsonValue())
      .setNext(AppJsonValue());

  dynamic getParam(ThemeValueRequest themeValueRequest) {
    return _jsonValueChain.getValue(themeValueRequest, this);
  }

  factory NbTheme.fromJson(Map json) {
    final theme = json[keyTheme];
    final colorPrimary = AppColor.fromJson(json[keyColorPrimary]);
    final colorSecondary = AppColor.fromJson(json[keyColorSecondary]);
    final colorNavigation = AppColor.fromJson(json[keyColorNavigation]);
    final colorBackground = AppColor.fromJson(json[keyColorBackground]);
    final colorScreenBackground = AppColor.fromJson(json[keyColorScreenBackground]);
    final colorScreenSecondaryBackground = AppColor.fromJson(json[keyColorScreenSecondaryBackground]);
    final colorCardBackground = AppColor.fromJson(json[keyColorCardBackground]);
    final colorCardSecondaryBackground = AppColor.fromJson(json[keyColorCardSecondaryBackground]);
    final colorButtonDisabled = AppColor.fromJson(json[keyColorButtonDisabled]);
    final colorActionButton = AppColor.fromJson(json[keyColorActionButton]);
    final colorPrimaryHighlight = AppColor.fromJson(json[keyColorHighlightPrimary]);
    final colorSecondaryHighlight = AppColor.fromJson(json[keyColorHighlightSecondary]);
    final colorIconLabel = AppColor.fromJson(json[keyColorIconLabel]);
    final colorPrimaryButton = AppColor.fromJson(json[keyColorButtonPrimary]);
    final colorSecondaryButton = AppColor.fromJson(json[keyColorButtonSecondary]);
    final colorPrimaryText = AppColor.fromJson(json[keyColorPrimaryText]);
    final colorSecondaryText = AppColor.fromJson(json[keyColorSecondaryText]);
    final colorTertiaryText = AppColor.fromJson(json[keyColorTertiaryText]);
    final colorTabBar = AppColor.fromJson(json[keyColorTabBar]);
    final sizeLogo = sizeFromJson(json[keySizeLogo]);
    final fontFamily = json[keyFontFamily];
    final overridesScreen = json[keyOverridesScreen];
    final overridesCard = json[keyOverridesCard];
    final statusBarStyle = statusBarStyleJson(json[keyStatusBarStyle]);

    final nbTheme = NbTheme._(
      key: theme,
      colorPrimary: colorPrimary.get(),
      colorSecondary: colorSecondary.get(),
      colorPrimaryHighlight: colorPrimaryHighlight.get(),
      colorSecondaryHighlight: colorSecondaryHighlight.get(),
      colorPrimaryButton: colorPrimaryButton.get(),
      colorSecondaryButton: colorSecondaryButton.get(),
      colorPrimaryText: colorPrimaryText.get(),
      colorSecondaryText: colorSecondaryText.get(),
      colorTertiaryText: colorTertiaryText.get(),
      colorNavigation: colorNavigation.get(),
      colorBackground: colorBackground.get(),
      colorScreenBackground: colorScreenBackground.get(),
      colorScreenSecondaryBackground: colorScreenSecondaryBackground.get(),
      colorCardBackground: colorCardBackground.get(),
      colorCardSecondaryBackground: colorCardSecondaryBackground.get(),
      colorButtonDisabled: colorButtonDisabled.get(),
      colorActionButton: colorActionButton.get(),
      colorIconLabel: colorIconLabel.get(),
      colorTabBar: colorTabBar.get(),
      sizeLogo: sizeLogo,
      fontFamily: fontFamily,
      overridesScreen: overridesScreen,
      overridesCard: overridesCard,
      statusBarStyle: statusBarStyle,
    );
    return nbTheme;
  }

  final String key;
  final Color colorPrimary;
  final Color colorSecondary;
  final Color colorPrimaryHighlight;
  final Color colorSecondaryHighlight;
  final Color colorPrimaryButton;
  final Color colorSecondaryButton;
  final Color colorNavigation;
  final Color colorBackground;
  final Color colorScreenBackground;
  final Color colorScreenSecondaryBackground;
  final Color colorCardBackground;
  final Color colorCardSecondaryBackground;
  final Color colorButtonDisabled;
  final StatusBarStyle statusBarStyle;
  final Color colorPrimaryText;
  final Color colorSecondaryText;
  final Color colorTertiaryText;
  final String fontFamily;
  final Color colorActionButton;
  final Color colorTabBar;
  final Color colorIconLabel;
  final Size sizeLogo;
  final Map? overridesScreen;
  final Map? overridesCard;

  NbTheme._({
    required this.key,
    required this.colorPrimary,
    required this.colorSecondary,
    required this.colorPrimaryHighlight,
    required this.colorSecondaryHighlight,
    required this.colorPrimaryButton,
    required this.colorSecondaryButton,
    required this.colorNavigation,
    required this.colorBackground,
    required this.colorScreenBackground,
    required this.colorScreenSecondaryBackground,
    required this.colorCardBackground,
    required this.colorCardSecondaryBackground,
    required this.colorButtonDisabled,
    required this.statusBarStyle,
    required this.colorPrimaryText,
    required this.colorSecondaryText,
    required this.colorTertiaryText,
    required this.fontFamily,
    required this.colorActionButton,
    required this.colorTabBar,
    required this.colorIconLabel,
    required this.sizeLogo,
    required this.overridesScreen,
    required this.overridesCard,
  }) {
    _attrs.putIfAbsent(keyTheme, () => key);
    _attrs.putIfAbsent(keyColorPrimary, () => colorPrimary);
    _attrs.putIfAbsent(keyColorSecondary, () => colorSecondary);
    _attrs.putIfAbsent(keyColorNavigation, () => colorNavigation);
    _attrs.putIfAbsent(keyColorBackground, () => colorBackground);
    _attrs.putIfAbsent(keyColorScreenBackground, () => colorScreenBackground);
    _attrs.putIfAbsent(keyColorScreenSecondaryBackground, () => colorScreenSecondaryBackground);
    _attrs.putIfAbsent(keyColorCardBackground, () => colorCardBackground);
    _attrs.putIfAbsent(keyColorCardSecondaryBackground, () => colorCardSecondaryBackground);
    _attrs.putIfAbsent(keyColorButtonDisabled, () => colorButtonDisabled);
    _attrs.putIfAbsent(keyColorActionButton, () => colorActionButton);
    _attrs.putIfAbsent(keyColorHighlightPrimary, () => colorPrimaryHighlight);
    _attrs.putIfAbsent(keyColorHighlightSecondary, () => colorSecondaryHighlight);
    _attrs.putIfAbsent(keyColorIconLabel, () => colorIconLabel);
    _attrs.putIfAbsent(keyColorButtonPrimary, () => colorPrimaryButton);
    _attrs.putIfAbsent(keyColorButtonSecondary, () => colorSecondaryButton);
    _attrs.putIfAbsent(keyColorPrimaryText, () => colorPrimaryText);
    _attrs.putIfAbsent(keyColorSecondaryText, () => colorSecondaryText);
    _attrs.putIfAbsent(keyColorTertiaryText, () => colorTertiaryText);
    _attrs.putIfAbsent(keyColorTabBar, () => colorTabBar);
    _attrs.putIfAbsent(keySizeLogo, () => sizeLogo);
    _attrs.putIfAbsent(keyFontFamily, () => fontFamily);
    _attrs.putIfAbsent(keyStatusBarStyle, () => statusBarStyle);
  }

  dynamic getAttr(String key) {
    return _attrs[key];
  }

  dynamic getOverriddenAttr(Map overrides, String key) {
    final overriddenValue = overrides[key];
    if (overriddenValue.contains('color')) {
      return AppColor.fromJson(overriddenValue).color;
    }
    if (overriddenValue.contains('size')) {
      return sizeFromJson(overriddenValue);
    }
    if (overriddenValue.contains('size')) {
      return sizeFromJson(overriddenValue);
    }
    return overriddenValue;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is NbTheme && runtimeType == other.runtimeType && key == other.key;
}

class AppColor extends Equatable {
  static const grey1 = AppColor._('attr_color_grey_1', colorGrey1);
  static const grey2 = AppColor._('attr_color_grey_2', colorGrey2);
  static const grey3 = AppColor._('attr_color_grey_3', colorGrey3);
  static const blue1 = AppColor._('attr_color_blue_1', colorBlue1);
  static const blue2 = AppColor._('attr_color_blue_2', colorBlue2);
  static const blue3 = AppColor._('attr_color_blue_3', colorBlue3);
  static const red1 = AppColor._('attr_color_red_1', colorRed1);
  static const red2 = AppColor._('attr_color_red_2', colorRed2);
  static const red3 = AppColor._('attr_color_red_3', colorRed3);
  static const yellow1 = AppColor._('attr_color_yellow_1', colorYellow1);

  static AppColor fromJson(String key) {
    return _table[key]!;
  }

  Color get() => color;

  static const List<AppColor> list = [
    grey1,
    grey2,
    grey3,
    blue1,
    blue2,
    blue3,
    red1,
    red2,
    red3,
    yellow1,
  ];

  static final Map<String, AppColor> _table = {for (var e in list) e.attr: e};

  final String attr;
  final Color color;

  const AppColor._(this.attr, this.color);

  @override
  List<Object> get props => [attr];
}

const Color colorGrey1 = Color(0xFFA7A7A7);
const Color colorGrey2 = Color(0xFFACAEAC);
const Color colorGrey3 = Color(0xFFD9D9D6);
const Color colorRed1 = Color(0xFFB71C1C);
const Color colorRed2 = Color(0xFFB74C1E);
const Color colorRed3 = Color(0xFFB73A01);
const Color colorBlue1 = Color(0xFF3B5998);
const Color colorBlue2 = Color(0xFF518EF8);
const Color colorBlue3 = Color(0xFF518EA8);
const Color colorYellow1 = Color(0xFFF3FF3C);

enum StatusBarStyle { dark, light }

StatusBarStyle statusBarStyleJson(String value) {
  return StatusBarStyle.values.firstWhere((element) => element.toString().contains(value));
}

Size sizeFromJson(Map json) {
  double height = json['height'] * 1.0;
  double width = json['width'] * 1.0;
  return Size(height, width);
}

class ThemeValueRequest {
  String valueKey;
  String? screenKey;
  String? cardKey;

  ThemeValueRequest({
    required this.valueKey,
    this.screenKey,
    this.cardKey,
  });
}
