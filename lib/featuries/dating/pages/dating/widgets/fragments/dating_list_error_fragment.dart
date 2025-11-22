import 'package:flutter/material.dart';

class DatingListErrorFragment extends StatelessWidget {
  const DatingListErrorFragment({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
