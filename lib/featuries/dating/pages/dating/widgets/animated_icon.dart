import 'dart:math';

import 'package:flutter/cupertino.dart';

// Enum to define the possible animation commands
enum AnimationCommand { idle, show, disable, complete, completeAuto }

// Controller class to manage the animation state from outside the widget
class AnimationIconController {
  late final ValueNotifier<AnimationCommand> _commandNotifier;
  late final ValueNotifier<Offset> _shiftNotifier;

  AnimationIconController() {
    _commandNotifier = ValueNotifier(AnimationCommand.idle);
  }

  // Notifier to listen for command changes
  ValueNotifier<AnimationCommand> get commandNotifier => _commandNotifier;
  ValueNotifier<Offset> get shiftNotifier => _shiftNotifier;

  void setShift(Offset shift) {
    _shiftNotifier.value = shift;
  }

  // Command to trigger the "show" animation
  void show() {
    if (_commandNotifier.value != AnimationCommand.completeAuto) {
      _commandNotifier.value = AnimationCommand.show;
    }
  }

  // Command to trigger the "disable" animation
  void disable() {
    if (_commandNotifier.value != AnimationCommand.complete &&
        _commandNotifier.value != AnimationCommand.completeAuto) {
      _commandNotifier.value = AnimationCommand.disable;
    }
  }

  // Command to trigger the "complete" animation
  void complete() {
    if (_commandNotifier.value != AnimationCommand.completeAuto) {
      _commandNotifier.value = AnimationCommand.complete;
    }
  }

  // Command to trigger the "show" -> "complete" animation sequence
  void completeAuto() {
    _commandNotifier.value = AnimationCommand.completeAuto;
  }

  // Dispose the notifier when the controller is no longer needed
  void dispose() {
    if (_commandNotifier.value != AnimationCommand.completeAuto) {
      _commandNotifier.dispose();
    }
  }
}

// The stateful widget that performs the animations
class ControlledAnimationIcon extends StatefulWidget {
  final AnimationIconController controller;
  final Widget child;
  final double angle;

  const ControlledAnimationIcon({
    super.key,
    required this.controller,
    required this.child,
    this.angle = 45,
  });

  @override
  State<ControlledAnimationIcon> createState() =>
      _ControlledAnimationIconState();
}

class _ControlledAnimationIconState extends State<ControlledAnimationIcon>
    with TickerProviderStateMixin {
  // Animation controller for the show/disable animations
  late final AnimationController _showController;
  // Animation controller for the complete animation
  late final AnimationController _completeController;

  late final Animation<double> _scale;
  late final Animation<double> _opacity;
  late final Animation<double> _angle;

  late final Animation<double> _completeScale;
  late final Animation<double> _completeOpacity;

  @override
  void initState() {
    super.initState();

    // --- Initialize Show/Disable Controller and Animations ---
    _showController = AnimationController(
      duration: const Duration(milliseconds: 1),
      vsync: this,
    );

    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _showController, curve: Curves.easeOutBack),
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _showController, curve: Curves.easeIn));
    _angle = Tween<double>(begin: 0, end: widget.angle * (pi / 180.0)).animate(
      CurvedAnimation(parent: _showController, curve: Curves.easeInOut),
    );

    // --- Initialize Complete Controller and Animations ---
    _completeController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _completeScale = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _completeController, curve: Curves.easeInOut),
    );
    _completeOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _completeController, curve: Curves.easeIn),
    );

    // Add listener to handle commands from the controller
    widget.controller.commandNotifier.addListener(_handleCommand);

    // Chain animations for completeAuto
    _showController.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          widget.controller.commandNotifier.value ==
              AnimationCommand.completeAuto) {
        _completeController.forward();
      }
    });

    // Reset animation if complete controller finishes
    _completeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showController.reset();
        _completeController.reset();
        // After auto-complete, set state to idle so it can be re-run
        if (widget.controller.commandNotifier.value ==
            AnimationCommand.completeAuto) {
          widget.controller._commandNotifier.value = AnimationCommand.idle;
        }
      }
    });
  }

  void _handleCommand() {
    switch (widget.controller.commandNotifier.value) {
      case AnimationCommand.show:
        if (_completeController.isAnimating) _completeController.stop();
        _showController.forward();
        break;
      case AnimationCommand.disable:
        if (_completeController.isAnimating) _completeController.stop();
        _showController.reverse();
        break;
      case AnimationCommand.complete:
        if (_showController.value == 1.0) {
          _completeController.forward();
        }
        break;
      case AnimationCommand.completeAuto:
        _showController.reset();
        _completeController.reset();
        _showController.forward();
        break;
      case AnimationCommand.idle:
        if (widget.controller.commandNotifier.value == AnimationCommand.idle) {
          _showController.reset();
          _completeController.reset();
        }
        break;
    }
  }

  @override
  void dispose() {
    widget.controller.commandNotifier.removeListener(_handleCommand);
    _showController.dispose();
    _completeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_showController, _completeController]),
      builder: (context, child) {
        // Calculate final transformations by combining both animations
        final finalScale = _scale.value * _completeScale.value;
        final finalOpacity = _opacity.value * _completeOpacity.value;

        return Opacity(
          opacity: finalOpacity,
          child: Transform.rotate(
            angle: _angle.value,
            child: Transform.scale(scale: finalScale, child: child),
          ),
        );
      },
      child: widget.child,
    );
  }
}
