import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';

class StoreTabSelector extends StatelessWidget {
  const StoreTabSelector(
      {super.key, this.onTap, required this.title, required this.selected});
  final Function()? onTap;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? colors(context).primaryColor ??
                        AppStaticColor.primaryColor
                    : Colors.transparent,
                width: 2.h,
              ),
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: textStyle.bodyText.copyWith(
                fontWeight: FontWeight.w600,
                color: selected
                    ? colors(context).primaryColor ??
                        AppStaticColor.primaryColor
                    : AppStaticColor.grayColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
