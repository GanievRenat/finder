import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Анимация переходов маршрутизатора

class Transition {
  const Transition._();

  static CustomTransitionPage fade({
    required ValueKey<String> pageKey,
    required String name,
    required Widget child,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: kThemeAnimationDuration,
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      if (animation.status == AnimationStatus.reverse) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      }

      return FadeTransition(opacity: animation, child: child);
    },
  );

  static CustomTransitionPage noAnimation({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: kThemeAnimationDuration,
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );

  static CustomTransitionPage bottomSheet({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    opaque: true, // Не перекрывает основной экран
    barrierDismissible: true,
    child: child,
    name: name,
    fullscreenDialog: false,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      showModalBottomSheet(context: context, builder: (context) => child);
      return child;
    },
  );

  static CustomTransitionPage slide({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: kThemeAnimationDuration,
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage slideRightToLeft({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: Duration(milliseconds: 300),
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage slideRightToLeftToSlow({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage slideSlow({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: Duration(milliseconds: 800),
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage fadeMiddle({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: Duration(milliseconds: 600),
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = 0;
      const double end = 1;
      final tween = Tween<double>(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return FadeTransition(opacity: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage fadeSlow({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: Duration(milliseconds: 900),
    reverseTransitionDuration: Duration(milliseconds: 900),
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const double begin = 0;
      const double end = 1;
      final tween = Tween<double>(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return FadeTransition(opacity: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage slideToRight({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    key: pageKey,
    transitionDuration: kThemeAnimationDuration,
    reverseTransitionDuration: kThemeAnimationDuration,
    child: child,
    name: name,
    fullscreenDialog: true,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );

  static CustomTransitionPage matching({
    required ValueKey<String> pageKey,
    required Widget child,
    required String name,
  }) => CustomTransitionPage<void>(
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      final offset = Tween<Offset>(
        begin: const Offset(2, 0),
        end: Offset.zero,
      ).animate(curved);

      final scale = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

      final opacity = Tween<double>(begin: 0.0, end: 1.0).animate(curved);

      return AnimatedBuilder(
        animation: curved,
        builder: (context, child) {
          final width = MediaQuery.of(context).size.width;

          // Формируем матрицу вручную, без устаревших translate/scale
          final matrix = Matrix4.identity()
            ..setEntry(3, 2, 0.0015) // перспектива
            ..multiply(Matrix4.translationValues(offset.value.dx * width, 0, 0))
            ..multiply(Matrix4.diagonal3Values(scale.value, scale.value, 1))
            ..multiply(Matrix4.rotationY((1 - scale.value) * 0.3));

          return Opacity(
            opacity: opacity.value,
            child: Transform(
              alignment: Alignment.center,
              transform: matrix,
              child: child,
            ),
          );
        },
        child: child,
      );
    },
  );
}
