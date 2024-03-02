import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';

AppColors colors(context) => Theme.of(context).extension<AppColors>()!;
ThemeData getAppTheme(
    {required BuildContext context, required bool isDarkTheme}) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        primaryColor: AppStaticColor.primaryColor,
        accentColor: AppStaticColor.accentColor,
        buttonColor: AppStaticColor.primaryColor,
        buttonTextColor: AppStaticColor.whiteColor,
        bodyTextColor:
            isDarkTheme ? AppStaticColor.whiteColor : AppStaticColor.grayColor,
        bodyTextSmallColor:
            isDarkTheme ? AppStaticColor.whiteColor : AppStaticColor.blackColor,
        titleTextColor:
            isDarkTheme ? AppStaticColor.whiteColor : AppStaticColor.blackColor,
        hintTextColor:
            isDarkTheme ? AppStaticColor.accentColor : AppStaticColor.grayColor,
      ),
    ],
    fontFamily: 'Open Sans',
    unselectedWidgetColor:
        isDarkTheme ? AppStaticColor.accentColor : AppStaticColor.grayColor,
    scaffoldBackgroundColor:
        isDarkTheme ? AppStaticColor.blackColor : AppStaticColor.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor:
          isDarkTheme ? AppStaticColor.blackColor : AppStaticColor.whiteColor,
      titleTextStyle: TextStyle(
        color:
            isDarkTheme ? AppStaticColor.whiteColor : AppStaticColor.blackColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color:
            isDarkTheme ? AppStaticColor.whiteColor : AppStaticColor.blackColor,
      ),
    ),
  );
}
