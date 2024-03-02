import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';

class AddressCard extends StatefulWidget {
  final UserAddress userAddress;
  const AddressCard({
    Key? key,
    required this.userAddress,
  }) : super(key: key);

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: colors(context).accentColor,
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(
            color: AppStaticColor.grayColor.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildCardHeader(userAddress: widget.userAddress, context: context),
          SizedBox(height: 5.h),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userAddress.name,
                    style: textStyle.bodyText.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppStaticColor.blackColor,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    widget.userAddress.phone,
                    style: textStyle.bodyText.copyWith(
                      color: AppStaticColor.blackColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${widget.userAddress.area}, ${widget.userAddress.flat}, ${widget.userAddress.addressLine1}, ${widget.userAddress.addressLine2}-${widget.userAddress.postCode}',
                    style: textStyle.bodyTextSmall.copyWith(
                      color: AppStaticColor.blackColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCardHeader(
      {required UserAddress userAddress, required BuildContext context}) {
    final textStyle = AppTextStyle(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Assets.images.locationPin
                .image(width: 30.sp, color: colors(context).primaryColor),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: AppStaticColor.blackColor,
              ),
              child: Center(
                child: Text(
                  getAddressTag(userAddress.addressName),
                  style: textStyle.bodyTextSmall.copyWith(
                    color: AppStaticColor.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  String getAddressTag(String tag) {
    if (tag == "home") {
      return S.of(context).home;
    } else if (tag == "office") {
      return S.of(context).office;
    } else {
      return S.of(context).other;
    }
  }
}
