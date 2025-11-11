import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MenuSelector extends StatefulWidget {
  const MenuSelector({
    super.key,
    required this.title,
    required this.values,
    required this.onChanged,
    this.canClear = true,
    this.initValue = '',
  });

  final String title;
  final Set<String> values;
  final String? initValue;
  final bool canClear;
  final Function(String value) onChanged;

  @override
  State<MenuSelector> createState() => _MenuSelectorState();
}

class _MenuSelectorState extends State<MenuSelector> {
  String selectValue = '';

  @override
  void initState() {
    super.initState();

    selectValue = widget.initValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: widget.values
          .map(
            (element) => MenuItemButton(
              onPressed: () {
                setState(() {
                  selectValue = element;
                });
                widget.onChanged(element);
              },
              child: Text(
                element,
                style: AppTheme.of(context).textStyle.bodyM.copyWith(
                  fontWeight: (selectValue == element) ? FontWeight.bold : null,
                ),
              ),
            ),
          )
          .toList(),
      builder: (_, MenuController controller, Widget? child) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: const Icon(Icons.edit),
          ),
          title: (selectValue.isEmpty)
              ? Text(
                  widget.title,
                  style: TextStyle(color: AppTheme.of(context).color.error),
                )
              : Text(selectValue),
          subtitle: (selectValue.isEmpty) ? null : Text(widget.title),
          trailing: (widget.canClear && selectValue.isNotEmpty)
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      selectValue = '';
                    });
                    widget.onChanged('');
                  },
                  icon: Icon(Icons.clear),
                )
              : null,
        );
      },
    );
  }
}
