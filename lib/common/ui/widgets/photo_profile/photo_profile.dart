import 'dart:nativewrappers/_internal/vm/lib/typed_data_patch.dart';

import 'package:flutter/material.dart';

class PhotoProfile extends StatelessWidget {
  const PhotoProfile({super.key, this.canEdit = false, this.imageData});

  final Uint8List? imageData;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
