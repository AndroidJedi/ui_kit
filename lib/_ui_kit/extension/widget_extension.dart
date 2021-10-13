import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:ui_kit/_ui_kit/widget/tap_detector_widget.dart';

typedef GestureOnTapChangeCallback = void Function(bool tapState);

extension StyledWidget on Widget {
  /// Applies a parent to a child
  /// ```dart
  /// final parentWidget = ({required Widget child}) => Styled.widget(child: child)
  ///   .alignment(Alignment.center)
  ///
  /// final childWidget = Text('some text')
  ///   .padding(all: 10)
  ///
  /// Widget build(BuildContext) => childWidget
  ///   .parent(parentWidget);
  /// ```
  Widget parent(Widget Function({required Widget child}) parent) => parent(child: this);

  Widget padding({
    Key? key,
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsets.only(
          top: top ?? vertical ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
          left: left ?? horizontal ?? all ?? 0.0,
          right: right ?? horizontal ?? all ?? 0.0,
        ),
        child: this,
      );

  Widget paddingDirectional({
    Key? key,
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? start,
    double? end,
  }) =>
      Padding(
        key: key,
        padding: EdgeInsetsDirectional.only(
          top: top ?? vertical ?? all ?? 0.0,
          bottom: bottom ?? vertical ?? all ?? 0.0,
          start: start ?? horizontal ?? all ?? 0.0,
          end: end ?? horizontal ?? all ?? 0.0,
        ),
        child: this,
      );

  Widget opacity(
    double opacity, {
    Key? key,
    bool alwaysIncludeSemantics = false,
  }) =>
      Opacity(
        key: key,
        opacity: opacity,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
        child: this,
      );

  Widget offstage({
    Key? key,
    bool offstage = true,
  }) =>
      Offstage(
        key: key,
        offstage: offstage,
        child: this,
      );

  Widget alignment(
    AlignmentGeometry alignment, {
    Key? key,
  }) =>
      Align(
        key: key,
        alignment: alignment,
        child: this,
      );

  Widget backgroundColor(
    Color color, {
    Key? key,
  }) =>
      DecoratedBox(
        key: key,
        child: this,
        decoration: BoxDecoration(color: color),
      );

  Widget backgroundImage(
    DecorationImage image, {
    Key? key,
  }) =>
      DecoratedBox(
        key: key,
        child: this,
        decoration: BoxDecoration(image: image),
      );

  Widget backgroundGradient(
    Gradient gradient, {
    Key? key,
  }) =>
      DecoratedBox(
        key: key,
        child: this,
        decoration: BoxDecoration(gradient: gradient),
      );

  Widget backgroundLinearGradient({
    Key? key,
    AlignmentGeometry begin = Alignment.centerLeft,
    AlignmentGeometry end = Alignment.centerRight,
    List<Color>? colors,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
  }) {
    BoxDecoration decoration = BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: colors ?? [],
        stops: stops,
        tileMode: tileMode,
        transform: transform,
      ),
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget backgroundRadialGradient({
    Key? key,
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
    List<Color>? colors,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
    AlignmentGeometry? focal,
    double focalRadius = 0.0,
    GradientTransform? transform,
  }) {
    BoxDecoration decoration = BoxDecoration(
      gradient: RadialGradient(
        center: center,
        radius: radius,
        colors: colors ?? [],
        stops: stops,
        tileMode: tileMode,
        focal: focal,
        focalRadius: focalRadius,
        transform: transform,
      ),
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget backgroundSweepGradient({
    Key? key,
    AlignmentGeometry center = Alignment.center,
    double startAngle = 0.0,
    double endAngle = pi * 2,
    List<Color>? colors,
    List<double>? stops,
    TileMode tileMode = TileMode.clamp,
    GradientTransform? transform,
  }) {
    BoxDecoration decoration = BoxDecoration(
      gradient: SweepGradient(
        center: center,
        startAngle: startAngle,
        endAngle: endAngle,
        colors: colors ?? [],
        stops: stops,
        tileMode: tileMode,
        transform: transform,
      ),
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget backgroundBlendMode(
    BlendMode blendMode, {
    Key? key,
  }) =>
      DecoratedBox(
        key: key,
        child: this,
        decoration: BoxDecoration(backgroundBlendMode: blendMode),
      );

  Widget backgroundBlur(
    double sigma, {
    Key? key,
  }) =>
      BackdropFilter(
        key: key,
        filter: ImageFilter.blur(
          sigmaX: sigma,
          sigmaY: sigma,
        ),
        child: this,
      );

  Widget borderRadius({
    Key? key,
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
  }) {
    BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeft ?? all ?? 0.0),
        topRight: Radius.circular(topRight ?? all ?? 0.0),
        bottomLeft: Radius.circular(bottomLeft ?? all ?? 0.0),
        bottomRight: Radius.circular(bottomRight ?? all ?? 0.0),
      ),
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget borderRadiusDirectional({
    Key? key,
    double? all,
    double? topStart,
    double? topEnd,
    double? bottomStart,
    double? bottomEnd,
  }) {
    BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(topStart ?? all ?? 0.0),
        topEnd: Radius.circular(topEnd ?? all ?? 0.0),
        bottomStart: Radius.circular(bottomStart ?? all ?? 0.0),
        bottomEnd: Radius.circular(bottomEnd ?? all ?? 0.0),
      ),
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget clipRRect({
    Key? key,
    double? all,
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    CustomClipper<RRect>? clipper,
    Clip clipBehavior = Clip.antiAlias,
  }) =>
      ClipRRect(
        key: key,
        child: this,
        clipper: clipper ?? null,
        clipBehavior: clipBehavior,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topLeft ?? all ?? 0.0),
          topRight: Radius.circular(topRight ?? all ?? 0.0),
          bottomLeft: Radius.circular(bottomLeft ?? all ?? 0.0),
          bottomRight: Radius.circular(bottomRight ?? all ?? 0.0),
        ),
      );

  Widget clipRect({
    Key? key,
    CustomClipper<Rect>? clipper,
    Clip clipBehavior = Clip.hardEdge,
  }) =>
      ClipRect(
        key: key,
        clipper: clipper,
        clipBehavior: clipBehavior,
        child: this,
      );

  Widget clipOval({Key? key}) => ClipOval(
        key: key,
        child: this,
      );

  Widget border({
    Key? key,
    double? all,
    double? left,
    double? right,
    double? top,
    double? bottom,
    Color color = const Color(0xFF000000),
    BorderStyle style = BorderStyle.solid,
  }) {
    BoxDecoration decoration = BoxDecoration(
      border: Border(
        left: (left ?? all) == null ? BorderSide.none : BorderSide(color: color, width: left ?? all ?? 0, style: style),
        right:
            (right ?? all) == null ? BorderSide.none : BorderSide(color: color, width: right ?? all ?? 0, style: style),
        top: (top ?? all) == null ? BorderSide.none : BorderSide(color: color, width: top ?? all ?? 0, style: style),
        bottom: (bottom ?? all) == null
            ? BorderSide.none
            : BorderSide(color: color, width: bottom ?? all ?? 0, style: style),
      ),
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget decorated({
    Key? key,
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
    DecorationPosition position = DecorationPosition.background,
  }) {
    BoxDecoration decoration = BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
      backgroundBlendMode: backgroundBlendMode,
      shape: shape,
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
      position: position,
    );
  }

  double _elevationOpacityCurve(double x) => pow(x, 1 / 16) / sqrt(pow(x, 2) + 2) + 0.2;

  // TODO: Animate elevation
  Widget elevation(
    double elevation, {
    Key? key,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color shadowColor = const Color(0xFF000000),
  }) =>
      Material(
        key: key,
        child: this,
        color: Colors.transparent,
        elevation: elevation,
        borderRadius: borderRadius,
        shadowColor: shadowColor,
      );

  Widget neumorphism({
    Key? key,
    required double elevation,
    BorderRadius borderRadius = BorderRadius.zero,
    Color backgroundColor = const Color(0xffEDF1F5),
    double curve = 0.0,
  }) {
    double offset = elevation / 2;
    int colorOffset = (40 * curve).toInt();
    final int Function(int, int) adjustColor = (int color, int colorOffset) {
      int colorVal = color + colorOffset;
      if (colorVal > 255)
        return 255;
      else if (colorVal < 0) return 0;
      return colorVal;
    };

    BoxDecoration decoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(
            adjustColor(backgroundColor.red, colorOffset),
            adjustColor(backgroundColor.green, colorOffset),
            adjustColor(backgroundColor.blue, colorOffset),
            1.0,
          ),
          Color.fromRGBO(
            adjustColor(backgroundColor.red, -colorOffset),
            adjustColor(backgroundColor.green, -colorOffset),
            adjustColor(backgroundColor.blue, -colorOffset),
            1.0,
          ),
        ],
        // stops: [0.90, 0.95],
      ),
      borderRadius: borderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.white,
          blurRadius: elevation.abs(),
          offset: Offset(-offset, -offset),
        ),
        BoxShadow(
          color: Color(0xAAA3B1C6),
          blurRadius: elevation.abs(),
          offset: Offset(offset, offset),
        ),
      ],
    );

    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget boxShadow({
    Key? key,
    Color color = const Color(0xFF000000),
    Offset offset = Offset.zero,
    double blurRadius = 0.0,
    double spreadRadius = 0.0,
  }) {
    BoxDecoration decoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: color,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
          offset: offset,
        ),
      ],
    );
    return DecoratedBox(
      key: key,
      child: this,
      decoration: decoration,
    );
  }

  Widget constrained({
    Key? key,
    double? width,
    double? height,
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    double minHeight = 0.0,
    double maxHeight = double.infinity,
  }) {
    BoxConstraints constraints = BoxConstraints(
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
    constraints = (width != null || height != null) ? constraints.tighten(width: width, height: height) : constraints;
    return ConstrainedBox(
      key: key,
      child: this,
      constraints: constraints,
    );
  }

  Widget width(
    double width, {
    Key? key,
  }) =>
      ConstrainedBox(
        key: key,
        child: this,
        constraints: BoxConstraints.tightFor(width: width),
      );

  Widget height(
    double height, {
    Key? key,
  }) =>
      ConstrainedBox(
        key: key,
        child: this,
        constraints: BoxConstraints.tightFor(height: height),
      );

  Widget scale({
    Key? key,
    double? all,
    double? x,
    double? y,
    Offset? origin,
    AlignmentGeometry alignment = Alignment.center,
    bool transformHitTests = true,
  }) =>
      Transform(
        key: key,
        transform: Matrix4.diagonal3Values(x ?? all ?? 0, y ?? all ?? 0, 1.0),
        alignment: alignment,
        child: this,
        origin: origin,
        transformHitTests: transformHitTests,
      );

  Widget translate({
    Key? key,
    required Offset offset,
    bool transformHitTests = true,
  }) =>
      Transform.translate(
        key: key,
        offset: offset,
        transformHitTests: transformHitTests,
        child: this,
      );

  Widget transform({
    Key? key,
    required Matrix4 transform,
    Offset? origin,
    AlignmentGeometry? alignment,
    bool transformHitTests = true,
  }) =>
      Transform(
        key: key,
        transform: transform,
        alignment: alignment,
        origin: origin,
        transformHitTests: transformHitTests,
        child: this,
      );

  Widget overflow({
    Key? key,
    AlignmentGeometry alignment = Alignment.center,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
  }) =>
      OverflowBox(
        key: key,
        alignment: alignment,
        minWidth: minWidth,
        maxWidth: minWidth,
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: this,
      );

  Widget scrollable({
    Key? key,
    Axis scrollDirection = Axis.vertical,
    bool reverse = false,
    bool? primary,
    ScrollPhysics? physics,
    ScrollController? controller,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
  }) =>
      SingleChildScrollView(
        key: key,
        child: this,
        scrollDirection: scrollDirection,
        reverse: reverse,
        primary: primary,
        physics: physics,
        controller: controller,
        dragStartBehavior: dragStartBehavior,
      );

  Widget expanded({
    Key? key,
    int flex = 1,
  }) =>
      Expanded(
        key: key,
        child: this,
        flex: flex,
      );

  Widget flexible({
    Key? key,
    int flex = 1,
    FlexFit fit = FlexFit.loose,
  }) =>
      Flexible(
        key: key,
        child: this,
        flex: flex,
        fit: fit,
      );

  Widget positioned({
    Key? key,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) =>
      Positioned(
        key: key,
        child: this,
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
      );

  Widget positionedDirectional({
    Key? key,
    double? start,
    double? end,
    double? top,
    double? bottom,
    double? width,
    double? height,
  }) =>
      PositionedDirectional(
        key: key,
        child: this,
        start: start,
        end: end,
        top: top,
        bottom: bottom,
        width: width,
        height: height,
      );

  Widget safeArea({
    Key? key,
    bool top = true,
    bool bottom = true,
    bool left = true,
    bool right = true,
  }) =>
      SafeArea(
        key: key,
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      );

  Widget semanticsLabel(
    String label, {
    Key? key,
  }) =>
      Semantics.fromProperties(
        key: key,
        properties: SemanticsProperties(label: label),
        child: this,
      );

  Widget onTap({
    Key? key,
    double? pressedOpacity,
    VoidCallback? onTap,
  }) =>
      TapDetectorWidget(
        child: this,
        pressedOpacity: pressedOpacity ?? 0.5,
        onPressed: onTap,
        key: key,
      );

  Widget aspectRatio({
    Key? key,
    required double aspectRatio,
  }) =>
      AspectRatio(
        key: key,
        aspectRatio: aspectRatio,
        child: this,
      );

  Widget center({
    Key? key,
    double? widthFactor,
    double? heightFactor,
  }) =>
      Center(
        key: key,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );

  Widget fittedBox({
    Key? key,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
  }) =>
      FittedBox(
        key: key,
        fit: fit,
        alignment: alignment,
        child: this,
      );

  Widget fractionallySizedBox({
    Key? key,
    AlignmentGeometry alignment = Alignment.center,
    double? widthFactor,
    double? heightFactor,
  }) =>
      FractionallySizedBox(
        key: key,
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      );
}
