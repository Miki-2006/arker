import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Colors.transparent, // фон прозрачный
      extensions: <ThemeExtension<dynamic>>[
        const GradientTheme(
          backgroundGradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFdad5fb),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
      ],
    );
  }
}

class GradientTheme extends ThemeExtension<GradientTheme> {
  final LinearGradient backgroundGradient;

  const GradientTheme({required this.backgroundGradient});

  @override
  GradientTheme copyWith({LinearGradient? backgroundGradient}) {
    return GradientTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  GradientTheme lerp(ThemeExtension<GradientTheme>? other, double t) {
    if (other is! GradientTheme) return this;
    return GradientTheme(
      backgroundGradient: LinearGradient.lerp(
        backgroundGradient,
        other.backgroundGradient,
        t,
      )!,
    );
  }
}