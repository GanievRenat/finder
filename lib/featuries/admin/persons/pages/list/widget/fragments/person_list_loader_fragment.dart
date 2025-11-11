import 'package:flutter/material.dart';

class PersonListLoaderFragment extends StatelessWidget {
  const PersonListLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
