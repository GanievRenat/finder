import 'package:flutter/material.dart';

class BackgroundProfile extends StatelessWidget {
  const BackgroundProfile({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 16,
        right: 16,
        bottom: 16 + MediaQuery.of(context).padding.bottom,
      ),
      child: child,
    );
  }
}
