import 'package:flutter/material.dart';

class PersonListErrorFragment extends StatelessWidget {
  const PersonListErrorFragment({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(error));
  }
}
