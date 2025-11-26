import 'package:flutter/material.dart';

class HeartbeatAnimation extends StatefulWidget {
  final Widget child;
  final Widget childWave;
  final Duration duration; // длительность одного цикла (1 удар)
  final Duration durationWave; // длительность одного цикла (1 удар)
  final Duration pause; // пауза между циклами
  final double minScale;
  final double maxScale;
  final bool repeat;
  final Curve curve;

  const HeartbeatAnimation({
    super.key,
    required this.child,
    required this.childWave,
    this.duration = const Duration(milliseconds: 700),
    this.durationWave = const Duration(milliseconds: 1400),
    this.pause = const Duration(milliseconds: 700),
    this.minScale = 0.8,
    this.maxScale = 1.3,
    this.repeat = true,
    this.curve = Curves.easeInOutCubic,
  });

  @override
  State<HeartbeatAnimation> createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _controller2;

  late final Animation<double> _scale;
  late final Animation<double> _scale2;
  late final Animation<double> _opacity;

  bool _disposed = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller2 = AnimationController(
      vsync: this,
      duration: widget.durationWave,
    );
    final curved = CurvedAnimation(parent: _controller2, curve: widget.curve);

    _scale2 = Tween<double>(begin: 1.0, end: 3.0).animate(curved);
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(curved);

    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: widget.maxScale),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.maxScale, end: widget.minScale),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: widget.minScale, end: 1.0),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    _startAnimationLoop();
  }

  Future<void> _startAnimationLoop() async {
    do {
      if (!_disposed) {
        await _controller.forward(from: 0);
        if (widget.repeat) {
          await Future.delayed(widget.pause);
          _controller2.forward(from: 0);
        }
      }
    } while (widget.repeat && !_disposed);
  }

  @override
  void dispose() {
    _disposed = true;

    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _scale2,
          builder: (context, child) {
            final matrix = Matrix4.identity()
              ..setEntry(3, 2, 0.0015) // лёгкая перспектива
              ..multiply(
                Matrix4.diagonal3Values(_scale2.value, _scale2.value, 1),
              );
            return Opacity(
              opacity: _opacity.value,
              child: Transform(
                alignment: Alignment.center,
                transform: matrix,
                child: widget.childWave,
              ),
            );
          },
          child: widget.child,
        ),
        AnimatedBuilder(
          animation: _scale,
          builder: (context, child) {
            final matrix = Matrix4.identity()
              ..multiply(
                Matrix4.diagonal3Values(_scale.value, _scale.value, 1),
              );
            return Transform(
              alignment: Alignment.center,
              transform: matrix,
              child: child,
            );
          },
          child: widget.child,
        ),
      ],
    );
  }
}
