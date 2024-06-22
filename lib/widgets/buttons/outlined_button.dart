import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/util/entensions.dart';

class AppOutlinedButton extends StatelessWidget {
  const AppOutlinedButton({
    Key? key,
    this.width = double.infinity,
    this.borderWidth = 1,
    this.height,
    this.buttonColor,
    this.borderColor,
    required this.title,
    this.onTap,
    this.titleColor,
    this.borderRadius = 30,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? borderColor;
  final String title;
  final Color? titleColor;
  final double borderWidth;
  final double borderRadius;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 60.h,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? AppStaticColor.primaryColor,
          border: Border.all(
            color: borderColor ??
                colors(context).primaryColor ??
                AppStaticColor.grayColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle.bodyText.copyWith(
              fontWeight: FontWeight.bold,
              color: titleColor ?? AppStaticColor.whiteColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class AppTextShrinkButton extends StatelessWidget {
  const AppTextShrinkButton(
      {Key? key,
      this.buttonColor,
      required this.title,
      this.onTap,
      this.titleColor,
      this.borderRadius = 30})
      : super(key: key);

  final Color? buttonColor;
  final String title;
  final Color? titleColor;
  final Function()? onTap;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: buttonColor ?? AppStaticColor.primaryColor,
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: textStyle.bodyText.copyWith(
                fontWeight: FontWeight.bold,
                color: titleColor ?? AppStaticColor.whiteColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            5.pw,
            Icon(
              Icons.arrow_forward_ios,
              size: 20.r,
              color: titleColor ?? AppStaticColor.whiteColor,
            )
          ],
        ),
      ),
    );
  }
}
