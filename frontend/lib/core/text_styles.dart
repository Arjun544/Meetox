import 'package:frontend/core/imports/core_imports.dart';

TextStyle globalTextStyle({
  required double fontSize,
  Color? color,
  double? letterSpacing,
  FontWeight? fontWeight,
}) =>
    TextStyle(
      color: color ?? Colors.black,
      fontSize: fontSize,
      letterSpacing: letterSpacing ?? 0.5,
      fontWeight: fontWeight ?? FontWeight.normal,
      fontFamily: 'Poppins',
    );
