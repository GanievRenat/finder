import 'package:flirta/common/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListTileItem extends StatelessWidget {
  const ListTileItem({
    super.key,
    required this.title,
    this.onTap,
    this.isLink = false,
  }) : _urlLink = '',
       _email = '',
       _emailBody = const {};

  const ListTileItem.link({super.key, required this.title, required String url})
    : onTap = null,
      isLink = true,
      _urlLink = url,
      _email = '',
      _emailBody = const {};

  const ListTileItem.email({
    super.key,
    required this.title,
    required String email,
    required Map<String, String> queryParameters,
  }) : onTap = null,
       isLink = true,
       _urlLink = '',
       _email = email,
       _emailBody = queryParameters;

  final String title;
  final VoidCallback? onTap;
  final bool isLink;
  final String _urlLink;
  final String _email;
  final Map<String, String> _emailBody;

  @override
  Widget build(BuildContext context) {
    Color activeColor = (onTap != null)
        ? !isLink
              ? AppTheme.of(context).color.neutralDarkDark
              : AppTheme.of(context).color.neutralDarkLight
        : AppTheme.of(context).color.neutralDarkLight;

    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: AppTheme.of(context).color.neutralLightLight,
      ),
      child: InkWell(
        onTap: (isLink)
            ? () async {
                if (_urlLink.isNotEmpty) {
                  if (await canLaunchUrl(Uri.parse(_urlLink))) {
                    await launchUrl(
                      Uri.parse(_urlLink),
                      mode: LaunchMode.externalApplication,
                    );
                  }
                } else if (_email.isNotEmpty) {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: _email,
                    queryParameters: _emailBody,
                  );
                  launchUrl(emailLaunchUri);
                }
              }
            : onTap,
        borderRadius: BorderRadius.circular(16.0),
        splashColor: AppTheme.of(context).color.primaryLightest,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: !isLink ? 24 : 16,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.of(
                    context,
                  ).textStyle.header4.copyWith(color: activeColor),
                ),
              ),
              Icon(
                !isLink
                    ? Icons.chevron_right_sharp
                    : Icons.arrow_outward_rounded,
                color: activeColor,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
