import 'package:flutter/material.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';

class CartSummaryText extends StatelessWidget {
  const CartSummaryText({
    super.key,
    required this.title,
    required this.subTitle,
    this.shouldBold = false,
    this.isDicount = false,
  });
  final String title;
  final String subTitle;
  final bool shouldBold;
  final bool isDicount;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: shouldBold
              ? textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                )
              : textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                ),
        ),
        Text(
          subTitle,
          style: shouldBold
              ? textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                )
              : isDicount
                  ? textStyle.bodyText.copyWith(
                      color: AppStaticColor.redColor,
                      fontWeight: FontWeight.bold,
                    )
                  : textStyle.bodyText.copyWith(
                      color: AppStaticColor.blackColor,
                    ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
