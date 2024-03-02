// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/top_nav_bar_icon_button.dart';
import 'package:grocerymart/widgets/misc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StoreProfile extends StatelessWidget {
  final Shop shopDetails;
  const StoreProfile({
    Key? key,
    required this.shopDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: 200.h,
        width: 390.w,
        child: Stack(
          children: [
            SizedBox(
              height: 134.h,
              width: 390.w,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: shopDetails.thumbnail,
                placeholder: (context, url) => const Icon(Icons.image),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Container(
              height: 134.h,
              width: 390.w,
              color: AppStaticColor.blackColor.withOpacity(0.4),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 40.h,
                width: 390.w,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Positioned(
              bottom: 30.h,
              child: Container(
                width: 390.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height: 72.h,
                        width: 72.h,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: shopDetails.logo,
                          placeholder: (context, url) =>
                              const Icon(Icons.image),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    16.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            shopDetails.name,
                            style: textStyle.bodyText.copyWith(
                              color: AppStaticColor.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          4.ph,
                          Text(
                            '${S.of(context).storeOpenT}: ${shopDetails.openTime} ${S.of(context).to} ${shopDetails.closeTime}',
                            style: textStyle.bodyTextSmall.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppStaticColor.whiteColor),
                          ),
                          16.ph,
                          Row(
                            children: [
                              Text(
                                '${shopDetails.totalProducts}+ ${S.of(context).items}',
                                style: textStyle.bodyTextSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              AppCustomDivider(height: 10.h),
                              const Expanded(child: SizedBox()),
                              Text(
                                '${shopDetails.totalCategories}+ ${S.of(context).categories}',
                                style: textStyle.bodyTextSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15.h,
                              ),
                              5.pw,
                              Text(
                                shopDetails.rating,
                                style: textStyle.bodyTextSmall.copyWith(
                                  color: AppStaticColor.blackColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ValueListenableBuilder<Box<HiveCartModel>>(
              valueListenable:
                  Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
              builder: (context, cartBox, _) {
                final cartItems = cartBox.values.toList();
                return Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: IconButton(
                                onPressed: () {
                                  context.nav.pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: colors(context).bodyTextColor,
                                ),
                              ),
                            ),
                            TopNavBarIconButton(
                              svgPath: Assets.svg.iconBasketColored,
                              onTap: () {
                                context.nav.pushNamed(Routes.cartScreen);
                              },
                            ),
                          ],
                        ),
                        cartItems.isNotEmpty
                            ? Positioned(
                                bottom: -10,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: colors(context).primaryColor,
                                  child: Center(
                                    child: Text(
                                      cartItems.length.toString(),
                                      style: textStyle.bodyTextSmall.copyWith(
                                        color: AppStaticColor.whiteColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
