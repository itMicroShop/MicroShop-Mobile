// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/full_width_button_with_icon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartRemoveDialog extends StatelessWidget {
  final Box<HiveCartModel> cartBox;
  const CartRemoveDialog({
    Key? key,
    required this.cartBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AlertDialog(
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        content: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                5.ph,
                SizedBox(
                  width: 300.w,
                  child: Text(
                    "Remove your previous items?",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                20.ph,
                SizedBox(
                  width: 300.w,
                  child: Text(
                    "You still have products from another shop.shall we start over with a fresh cart?",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                20.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 45.h,
                      width: 140.w,
                      child: TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                color: colors(context).primaryColor ??
                                    AppStaticColor.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          context.nav.pop();
                        },
                        child: Text(
                          'No',
                          style: textStyle.bodyText.copyWith(
                            color: colors(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 45.h,
                      width: 140.w,
                      child: AppTextButtonWithIcon(
                        title: 'Remove',
                        onTap: () {
                          cartBox.clear();
                          context.nav.pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  context.nav.pop();
                },
                child: Icon(
                  Icons.close,
                  color: colors(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
