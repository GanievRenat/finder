import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GallerySliderLoaderFragment extends StatelessWidget {
  const GallerySliderLoaderFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.of(context).color.primaryDarkset,
      ),
    );
  }
}
