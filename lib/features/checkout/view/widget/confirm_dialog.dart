// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/full_width_button_with_icon.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConfirmDialog extends StatelessWidget {
  final int orderId;
  final Box<HiveCartModel> cartBox;
  const ConfirmDialog({
    Key? key,
    required this.orderId,
    required this.cartBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: colors(context).primaryColor,
            radius: 30.r,
            child: Icon(
              Icons.check,
              size: 26.r,
              color: Colors.white,
            ),
          ),
          10.ph,
          Text(
            S.of(context).order_received,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          20.ph,
          Text(
            "${S.of(context).yourOrderID} #000$orderId",
            style: textStyle.subTitle
                .copyWith(fontSize: 16.sp, color: AppStaticColor.grayColor),
          ),
          20.ph,
          Text(
            S.of(context).orderDialogDes,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black.withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
          15.ph,
          GestureDetector(
            onTap: () {
              cartBox.clear();
              context.nav
                  .pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
            },
            child: SizedBox(
              height: 45.h,
              child: AppTextButtonWithIcon(
                title: S.of(context).continueShopping,
              ),
            ),
          )
        ],
      ),
    );
  }
}
