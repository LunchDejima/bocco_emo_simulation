import 'package:flutter/material.dart';

@immutable
class Style {
  final ColorScheme colorSheme;

  const Style({required this.colorSheme});

  static const light = Style(
    colorSheme: ColorScheme.light(
      primary: Color(0xFF9439C4),
    ),
  );
  static const dark = Style(
    colorSheme: ColorScheme.dark(
      primary: Color(0xFF2DC999),
    ),
  );
}

ThemeData getTheme(Style style) {
  return ThemeData(
    colorScheme: style.colorSheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.black,
      foregroundColor: style.colorSheme.primary,
    ),
  );
}