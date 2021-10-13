import 'package:flutter/material.dart';
import 'package:ui_kit/_ui_kit/extension/widget_extension.dart';
import 'package:ui_kit/_ui_kit/theme/nb_theme/nb_theme.dart';
import 'package:ui_kit/_ui_kit/theme/service/dynamic_theme.dart';
import 'package:ui_kit/_ui_kit/widget/app_icon.dart';

import 'widget/spacers.dart';

class UiKit {
  static Widget buttonCtaPrimary({required String label, required BuildContext context, VoidCallback? onTap}) => Text(
          label,
          style: TextStyles.title2.copyWith(
              color: onTap != null
                  ? DynamicTheme.of(context).getTheme().colorTextButtonCtaPrimaryActive
                  : DynamicTheme.of(context).getTheme().colorTextButtonCtaPrimaryDisabled))
      .padding(all: 16)
      .decorated(
        color: onTap != null
            ? DynamicTheme.of(context).getTheme().colorButtonCtaPrimaryActive
            : DynamicTheme.of(context).getTheme().colorButtonCtaPrimaryDisabled,
        borderRadius: BorderRadius.circular(10),
      )
      .alignment(Alignment.center)
      .onTap(onTap: onTap, pressedOpacity: 0.7);

  static Widget buttonCtaSecondary({required String label, required BuildContext context, VoidCallback? onTap}) =>
      Text(label,
              style: TextStyles.title2.copyWith(
                  color: onTap != null
                      ? DynamicTheme.of(context).getTheme().colorTextButtonCtaSecondaryActive
                      : DynamicTheme.of(context).getTheme().colorTextButtonCtaSecondaryDisabled))
          .padding(all: 16)
          .decorated(
            border: Border.all(
              color: onTap != null
                  ? DynamicTheme.of(context).getTheme().colorButtonCtaSecondaryActive
                  : DynamicTheme.of(context).getTheme().colorButtonCtaSecondaryDisabled,
            ),
            borderRadius: BorderRadius.circular(10),
          )
          .alignment(Alignment.center)
          .onTap(onTap: onTap, pressedOpacity: 0.5);

  static Widget buttonIconCtaPrimary({required String label, required BuildContext context, VoidCallback? onTap}) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: TextStyles.title2.copyWith(
                  color: onTap != null
                      ? DynamicTheme.of(context).getTheme().colorTextButtonCtaPrimaryActive
                      : DynamicTheme.of(context).getTheme().colorTextButtonCtaPrimaryDisabled)),
          spaceHorSm,
          const AppIcon(AppIcons.search, size: 24, color: ColorPalette.white)
        ],
      )
          .padding(all: 16)
          .decorated(
            color: onTap != null
                ? DynamicTheme.of(context).getTheme().colorButtonCtaPrimaryActive
                : DynamicTheme.of(context).getTheme().colorButtonCtaPrimaryDisabled,
            borderRadius: BorderRadius.circular(10),
          )
          .alignment(Alignment.center)
          .onTap(onTap: onTap, pressedOpacity: 0.7);

  static VSpace get spaceVertXs => VSpace(Insets.xs);

  static VSpace get spaceVertSm => VSpace(Insets.sm);

  static VSpace get spaceVertMed => VSpace(Insets.med);

  static VSpace get spaceVertLg => VSpace(Insets.lg);

  static VSpace get spaceVertXl => VSpace(Insets.xl);

  static HSpace get spaceHorXs => HSpace(Insets.xs);

  static HSpace get spaceHorSm => HSpace(Insets.sm);

  static HSpace get spaceHorMed => HSpace(Insets.med);

  static HSpace get spaceHorLg => HSpace(Insets.lg);

  static HSpace get spaceHorXl => HSpace(Insets.xl);
}
