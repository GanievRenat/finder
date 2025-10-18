import 'package:flutter/material.dart';

class AnimationClickWidget extends StatefulWidget {
  const AnimationClickWidget({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final Function() onTap;

  @override
  State<AnimationClickWidget> createState() => _AnimationClickWidgetState();
}

class _AnimationClickWidgetState extends State<AnimationClickWidget>
    with SingleTickerProviderStateMixin {
  double scale = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
          vsync: this,
          duration: const Duration(microseconds: 150),
          lowerBound: 0.0,
          upperBound: 0.015,
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - _controller.value;

    return MouseRegion(
      cursor: WidgetStateMouseCursor.clickable,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: () {
          _controller.reverse();
        },
        onTap: widget.onTap,
        child: Transform.scale(scale: scale, child: widget.child),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
