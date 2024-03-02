import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color? primaryColor;
  final Color? accentColor;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? bodyTextColor;
  final Color? bodyTextSmallColor;
  final Color? titleTextColor;
  final Color? hintTextColor;

  const AppColors({
    required this.primaryColor,
    required this.accentColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.bodyTextColor,
    required this.bodyTextSmallColor,
    required this.titleTextColor,
    required this.hintTextColor,
  });

  @override
  AppColors copyWith({
    Color? primaryColor,
    Color? accentColor,
    Color? buttonColor,
    Color? buttonTextColor,
    Color? titleTextColor,
    Color? bodyTextColor,
    Color? bodyTextSmallColor,
    Color? hintTextColor,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? primaryColor,
      accentColor: accentColor ?? accentColor,
      buttonColor: buttonColor ?? buttonColor,
      buttonTextColor: buttonTextColor ?? buttonTextColor,
      bodyTextColor: bodyTextColor ?? bodyTextColor,
      bodyTextSmallColor: bodyTextSmallColor ?? bodyTextSmallColor,
      titleTextColor: titleTextColor ?? titleTextColor,
      hintTextColor: hintTextColor ?? hintTextColor,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t),
      accentColor: Color.lerp(accentColor, other.accentColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t),
      bodyTextColor: Color.lerp(bodyTextColor, other.bodyTextColor, t),
      bodyTextSmallColor:
          Color.lerp(bodyTextSmallColor, other.bodyTextSmallColor, t),
      titleTextColor: Color.lerp(titleTextColor, other.titleTextColor, t),
      hintTextColor: Color.lerp(hintTextColor, other.hintTextColor, t),
    );
  }
}

class AppStaticColor {
  static const Color primaryColor = Color(0xFF1a475c);
  static const Color accentColor = Color(0xFFF3F4F6);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF030712);
  static const Color redColor = Color(0xffFF324B);
  static const Color grayColor = Color(0xff617986);
}
