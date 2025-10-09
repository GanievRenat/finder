import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.onAuth});

  final VoidCallback onAuth;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: widget.onAuth,
          child: const Text('Authenticate'),
        ),
      ),
    );
  }
}
