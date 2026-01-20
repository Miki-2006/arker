import 'package:flutter/material.dart';

class AddWidgetTheme extends ThemeExtension<AddWidgetTheme> {
  final Color backgroundColor;

  const AddWidgetTheme({required this.backgroundColor});

  @override
  ThemeExtension<AddWidgetTheme> copyWith({Color? backgroundColor}) {
    return AddWidgetTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  AddWidgetTheme lerp(ThemeExtension<AddWidgetTheme>? other, double t) {
    if (other is! AddWidgetTheme) return this;
    return AddWidgetTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }
}
