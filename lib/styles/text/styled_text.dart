import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String content;
  final String family;
  final int weight;
  final double size;
  final int color;
  final String style;

  const StyledText({
    super.key,
    required this.content,
    this.family = 'Ubuntu Condensed',
    this.weight = 400,
    this.size = 18,
    this.color = 0xFFFFFFFF,
    this.style = 'normal',
  });

  FontWeight get fontWeight {
    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.w400;
    }
  }

  FontStyle get fontStyle {
    if (style == 'italic') {
      return FontStyle.italic;
    } else {
      return FontStyle.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: family,
        fontWeight: fontWeight,
        fontSize: size,
        color: Color(color),
        fontStyle: fontStyle,
      ),
    );
  }
}
