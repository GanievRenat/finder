import 'package:flirta/common/ui/widgets/logo/logo.dart';
import 'package:flirta/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onFilter});

  final VoidCallback onFilter;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const LogoFlirta(),
        actions: [
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Assets.images.icons.filter.svg(),
            ),
            onPressed: widget.onFilter,
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to the Home Page!')),
    );
  }
}
