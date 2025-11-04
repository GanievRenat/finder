import 'package:flutter/material.dart';
import 'dart:math' as math;

class FlipAndGrowVerticalTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;

  const FlipAndGrowVerticalTransition({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeInOutCubic,
    this.onEnd,
  });

  @override
  State<FlipAndGrowVerticalTransition> createState() =>
      _FlipAndGrowVerticalTransitionState();
}

class _FlipAndGrowVerticalTransitionState
    extends State<FlipAndGrowVerticalTransition>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);

    /*_rotation = Tween<double>(
      begin: 0.0,
      end: math.pi, // 180° вращение по Y
    ).animate(curved);
    _scale = Tween<double>(begin: 1.0, end: 5.0).animate(curved);
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(curved);*/

    _rotation = Tween<double>(
      begin: 0.0,
      end: math.pi * 2, // 180° вращение по Y
    ).animate(curved);
    _scale = Tween<double>(begin: 5.0, end: 1.0).animate(curved);
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

    /*_controller.reverse().whenComplete(() {
      if (widget.onEnd != null) widget.onEnd!();
    });*/
    _controller.forward().whenComplete(() {
      if (widget.onEnd != null) widget.onEnd!();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final matrix = Matrix4.identity()
          ..setEntry(3, 2, 0.0015) // лёгкая перспектива
          ..multiply(Matrix4.rotationY(_rotation.value))
          ..multiply(Matrix4.diagonal3Values(_scale.value, _scale.value, 1));

        return Opacity(
          opacity: _opacity.value,
          child: Transform(
            alignment: Alignment.center,
            transform: matrix,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
