import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/util/entensions.dart';

class AppTextButtonWithIcon extends StatelessWidget {
  const AppTextButtonWithIcon({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.buttonColor,
    required this.title,
    this.onTap,
    this.titleColor,
    this.icon,
  }) : super(key: key);
  final double? width;
  final double? height;
  final Color? buttonColor;
  final String title;
  final Color? titleColor;
  final Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 60.h,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? colors(context).primaryColor,
          borderRadius: BorderRadius.circular(30.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
            icon != null
                ? Icon(
                    icon,
                    size: 18.h,
                    color: titleColor ?? AppStaticColor.whiteColor,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
