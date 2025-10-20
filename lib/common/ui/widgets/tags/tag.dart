import 'package:flirta/common/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class Tag extends StatefulWidget {
  const Tag({
    super.key,
    required this.name,
    required this.onChange,
    this.isSelect = false,
    this.selectIcon,
  });

  final String name;
  final bool isSelect;
  final Widget? selectIcon;
  final Function(bool select) onChange;

  @override
  State<Tag> createState() => _TagState();
}

class _TagState extends State<Tag> {
  bool _select = false;

  @override
  void initState() {
    super.initState();

    _select = widget.isSelect;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChange(!_select);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _select
              ? AppTheme.of(context).color.primaryDarkset
              : AppTheme.of(context).color.primaryLightest,
        ),

        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: (widget.selectIcon != null && _select)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTagLabel(),
                  SizedBox(width: 4),
                  widget.selectIcon!,
                ],
              )
            : _buildTagLabel(),
      ),
    );
  }

  Widget _buildTagLabel() {
    return Text(
      widget.name.toUpperCase(),
      style: AppTheme.of(context).textStyle.captionM.copyWith(
        color: _select
            ? AppTheme.of(context).color.neutralLightLightest
            : AppTheme.of(context).color.neutralDarkDarkset,
      ),
    );
  }

  @override
  void didUpdateWidget(Tag oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isSelect != widget.isSelect) {
      setState(() {
        _select = widget.isSelect;
      });
    }
  }
}
