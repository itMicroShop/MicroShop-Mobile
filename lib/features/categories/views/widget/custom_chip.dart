import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';

class SelectChip extends StatelessWidget {
  const SelectChip({
    super.key,
    required this.isSelected,
    required this.title,
    this.onTap,
  });
  final bool isSelected;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppStaticColor.whiteColor : Colors.transparent,
          borderRadius: BorderRadius.circular(17.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Center(
          child: Text(
            title,
            style: textStyle.bodyTextSmall.copyWith(
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? colors(context).primaryColor
                  : AppStaticColor.grayColor,
            ),
          ),
        ),
      ),
    );
  }
}
