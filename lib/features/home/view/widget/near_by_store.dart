// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/features/dashboard/logic/misc_providers.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/features/shop/view/widget/seller_card.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/entensions.dart';

import '../../../../config/theme.dart';

class NearbyStoreWidget extends ConsumerWidget {
  final List<Shop> shopList;
  const NearbyStoreWidget({
    super.key,
    required this.shopList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = AppTextStyle(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
              color: colors(context).accentColor ?? AppStaticColor.accentColor,
              blurRadius: 2,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).nearByStore,
                style: textStyle.subTitle,
              ),
              GestureDetector(
                onTap: () {
                  ref.watch(homeTabControllerProvider).animateToPage(2,
                      duration: 200.miliSec, curve: Curves.easeInOutCubic);
                },
                child: Text(
                  S.of(context).viewAll,
                  style: textStyle.bodyText.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colors(context).primaryColor),
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          shopList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: shopList.length < 4 ? shopList.length : 4,
                  itemBuilder: ((context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: SellerCard(
                          shop: shopList[index],
                          cardColor: colors(context).accentColor,
                        ),
                      )),
                )
              : SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      S.of(context).shopNotfound,
                      style: textStyle.subTitle,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
