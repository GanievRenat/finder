import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ContainerGroup extends StatelessWidget {
  const ContainerGroup({super.key, required this.child, this.title = ''});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Text(title, style: AppTheme.of(context).textStyle.header3),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16),
              child: Divider(),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
