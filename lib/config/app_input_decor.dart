import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';

class AppInputDecor {
  AppInputDecor._(); // This class is not meant to be instantiated.
  static InputDecoration loginPageInputDecor = InputDecoration(
    isDense: false,
    contentPadding: const EdgeInsets.all(15),
    hintStyle: const TextStyle(
      color: AppStaticColor.blackColor,
      fontSize: 16,
    ),
    filled: true,
    fillColor: AppStaticColor.accentColor,
    errorStyle: TextStyle(color: AppStaticColor.redColor, fontSize: 16.sp),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  );
  static InputDecoration roundedInputDecor = InputDecoration(
    isDense: false,
    contentPadding: const EdgeInsets.all(15),
    hintStyle: const TextStyle(color: AppStaticColor.blackColor, fontSize: 16),
    filled: true,
    fillColor: AppStaticColor.accentColor,
    errorStyle: const TextStyle(
      color: AppStaticColor.blackColor,
      fontSize: 16,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(67),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(67),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(67),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(67),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  );
}
