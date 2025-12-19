import 'package:flirta/common/di/init_di.dart';
import 'package:flirta/common/service/secure_storage_service.dart';
import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flirta/featuries/chat/pages/photo_gallery/gallery/state/gallery_cubit.dart';
import 'package:flirta/featuries/chat/widget/person_photo.dart';
import 'package:flutter/material.dart';

import 'package:group_grid_view/group_grid_view.dart';

class GalleryDataFragment extends StatelessWidget {
  const GalleryDataFragment({
    super.key,
    required this.onSliderPhoto,
    required this.onPayWall,
    required this.isPremium,
    required this.dataSource,
    required this.modelId,
  });

  final Function(String fileName) onSliderPhoto;
  final Function() onPayWall;
  final List<PhotoGroup> dataSource;
  final bool isPremium;
  final String modelId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GroupGridView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        sectionCount: dataSource.length,
        headerForSection: (section) => Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.of(context).color.primaryLightest,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              dataSource[section].sectionName,
              style: AppTheme.of(context).textStyle.actionM.copyWith(
                color: AppTheme.of(context).color.neutralDarkLightest,
              ),
            ),
          ),
        ),
        itemInSectionBuilder: (_, indexPath) {
          final data = dataSource[indexPath.section].listItems[indexPath.index];
          return PersonPhoto(
            isPremium: isPremium,
            imageBite: getIt<SecureStorageService>().getImage(modelId, data),
            onTap: (isPremium) {
              if (isPremium) {
                onSliderPhoto(data);
              } else {
                onPayWall();
              }
            },
          );
        },
        itemInSectionCount: (section) => dataSource[section].listItems.length,
      ),
    );
  }
}
