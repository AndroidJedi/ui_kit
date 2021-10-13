import 'package:flutter/material.dart';

class NbTheme {
  static const defaultTheme = NbTheme._(
    colorButtonCtaPrimaryActive: ColorPalette.electricIndigo,
    colorButtonCtaPrimaryDisabled: ColorPalette.grey2,
    colorTextButtonCtaPrimaryActive: ColorPalette.white,
    colorTextButtonCtaPrimaryDisabled: ColorPalette.grey3,
    colorButtonCtaSecondaryActive: ColorPalette.electricIndigo,
    colorButtonCtaSecondaryDisabled: ColorPalette.grey2,
    colorTextButtonCtaSecondaryActive: ColorPalette.electricIndigo,
    colorTextButtonCtaSecondaryDisabled: ColorPalette.grey3,
  );

  final Color colorButtonCtaPrimaryActive;
  final Color colorButtonCtaPrimaryDisabled;
  final Color colorTextButtonCtaPrimaryActive;
  final Color colorTextButtonCtaPrimaryDisabled;

  final Color colorButtonCtaSecondaryActive;
  final Color colorButtonCtaSecondaryDisabled;
  final Color colorTextButtonCtaSecondaryActive;
  final Color colorTextButtonCtaSecondaryDisabled;

  const NbTheme._({
    required this.colorButtonCtaPrimaryActive,
    required this.colorButtonCtaPrimaryDisabled,
    required this.colorTextButtonCtaPrimaryActive,
    required this.colorTextButtonCtaPrimaryDisabled,
    required this.colorButtonCtaSecondaryActive,
    required this.colorButtonCtaSecondaryDisabled,
    required this.colorTextButtonCtaSecondaryActive,
    required this.colorTextButtonCtaSecondaryDisabled,
  });
}

class FontSizes {
  static double get scale => 1;

  static double get s10 => 10 * scale;

  static double get s11 => 11 * scale;

  static double get s12 => 12 * scale;

  static double get s14 => 14 * scale;

  static double get s16 => 16 * scale;

  static double get s24 => 24 * scale;

  static double get s48 => 48 * scale;
}

class Fonts {
  static const String roboto = "Roboto";
}

class TextStyles {
  static const TextStyle roboto = TextStyle(fontFamily: Fonts.roboto, fontWeight: FontWeight.w400);

  static TextStyle get h1 => roboto.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: FontSizes.s48,
      );

  static TextStyle get h2 => h1.copyWith(
        fontSize: FontSizes.s24,
      );

  static TextStyle get h3 => h1.copyWith(
        fontSize: FontSizes.s14,
      );

  static TextStyle get title1 => roboto.copyWith(fontWeight: FontWeight.bold, fontSize: FontSizes.s16);

  static TextStyle get title2 => title1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: FontSizes.s14,
      );

  static TextStyle get body1 => roboto.copyWith(fontWeight: FontWeight.normal, fontSize: FontSizes.s14);

  static TextStyle get body2 => body1.copyWith(
        fontSize: FontSizes.s12,
      );

  static TextStyle get body3 => body1.copyWith(fontSize: FontSizes.s12, fontWeight: FontWeight.bold);
}

class Insets {
  static double scale = 1;
  static double offsetScale = 1;

  static double get xs => 4 * scale;

  static double get sm => 8 * scale;

  static double get med => 12 * scale;

  static double get lg => 16 * scale;

  static double get xl => 32 * scale;

  // Offset, used for the edge of the window, or to separate large sections in the app
  static double get offset => 40 * offsetScale;
}

enum AppIcons {
  search,
}

class ColorPalette {
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey1 = Color(0xFFA7A7A7);
  static const Color grey2 = Color(0xFFACAEAC);
  static const Color grey3 = Color(0xFFD9D9D6);
  static const Color red1 = Color(0xFFB71C1C);
  static const Color red2 = Color(0xFFB74C1E);
  static const Color red3 = Color(0xFFB73A01);
  static const Color blue1 = Color(0xFF3B5998);
  static const Color blue2 = Color(0xFF518EF8);
  static const Color electricIndigo = Color(0xFF5700FF);
  static const Color blue3 = Color(0xFF518EA8);
  static const Color yellow1 = Color(0xFFF3FF3C);
}
