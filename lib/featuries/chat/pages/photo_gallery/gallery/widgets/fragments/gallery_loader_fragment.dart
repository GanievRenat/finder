import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GalleryLoaderFragment extends StatelessWidget {
  const GalleryLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.of(context).color.primaryDarkset,
      ),
    );
  }
}
