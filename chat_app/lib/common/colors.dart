import 'package:flutter/material.dart';

class ColorPalette {
  static ColorPalette colorPalette = ColorPalette._();
  factory ColorPalette() {
    return colorPalette;
  }
  ColorPalette._();
  static Color? primaryColor = Colors.teal[900];
  static Color? switchColor = Colors.teal[100];
  static Color? secondaryColor = Colors.white;
}
