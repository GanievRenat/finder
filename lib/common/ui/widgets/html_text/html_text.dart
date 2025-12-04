import 'package:flutter/material.dart';

class HtmlText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const HtmlText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      _parseText(text, style ?? DefaultTextStyle.of(context).style),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  InlineSpan _parseText(String text, TextStyle defaultStyle) {
    final List<TextSpan> children = [];
    int currentIndex = 0;
    final regex = RegExp(r'<(b|i|u)>(.*?)</\1>', caseSensitive: false);

    for (final match in regex.allMatches(text)) {
      // Текст перед тегом
      if (match.start > currentIndex) {
        children.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: defaultStyle,
          ),
        );
      }

      // Текст внутри тега
      final tag = match.group(1)!.toLowerCase();
      final content = match.group(2)!;

      TextStyle tagStyle;
      switch (tag) {
        case 'b':
          tagStyle = defaultStyle.copyWith(fontWeight: FontWeight.bold);
          break;
        case 'i':
          tagStyle = defaultStyle.copyWith(fontStyle: FontStyle.italic);
          break;
        case 'u':
          tagStyle = defaultStyle.copyWith(
            decoration: TextDecoration.underline,
          );
          break;
        default:
          tagStyle = defaultStyle;
      }

      children.add(TextSpan(text: content, style: tagStyle));

      currentIndex = match.end;
    }

    // Оставшийся текст
    if (currentIndex < text.length) {
      children.add(
        TextSpan(text: text.substring(currentIndex), style: defaultStyle),
      );
    }

    return TextSpan(children: children);
  }
}
