import 'package:flutter/material.dart';

class TapDetectorWidget extends StatefulWidget {
  final Widget child;
  final double pressedOpacity;
  final VoidCallback? onPressed;

  const TapDetectorWidget({
    required this.child,
    this.onPressed,
    this.pressedOpacity = 0.5,
    Key? key,
  }) : super(key: key);

  @override
  _TapDetectorWidgetState createState() => _TapDetectorWidgetState();
}

class _TapDetectorWidgetState extends State<TapDetectorWidget> with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _opacityController = AnimationController(duration: const Duration(milliseconds: 200), value: 0.0, vsync: this);
    _opacityAnimation = _opacityController.drive(CurveTween(curve: Curves.decelerate)).drive(_opacityTween);
    _setTween();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _opacityAnimation,
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: widget.onPressed != null ? _handleTapDown : null,
            onTapUp: widget.onPressed != null ? _handleTapUp : null,
            onTapCancel: widget.onPressed != null ? _handleTapCancel : null,
            onTap: widget.onPressed,
            child: widget.child));
  }

  @override
  void didUpdateWidget(covariant TapDetectorWidget oldWidget) {
    _setTween();
    super.didUpdateWidget(oldWidget);
  }

  void _setTween() {
    _opacityTween.end = widget.pressedOpacity;
  }

  void _animate() {
    if (_opacityController.isAnimating) return;
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _opacityController.animateTo(1.0, duration: kFadeOutDuration)
        : _opacityController.animateTo(0.0, duration: kFadeInDuration);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }
}
