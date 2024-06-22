import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({
    super.key,
    required this.itemSvgs,
    required this.menuSvg,
    required this.selectedIndex,
    required this.onSelect,
  });
  final List<String> itemSvgs;
  final String menuSvg;
  final int selectedIndex;
  final Function(int? index) onSelect;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return SizedBox(
      height: 88.h,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 64.h,
              width: 390.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors(context).accentColor ??
                          AppStaticColor.accentColor,
                      blurRadius: 5,
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...List.generate(
                    itemSvgs.length + 1,
                    (index) {
                      if (index == (itemSvgs.length / 2)) {
                        return const SizedBox();
                      } else if (index > (itemSvgs.length / 2)) {
                        return GestureDetector(
                          onTap: () {
                            onSelect(index - 1);
                          },
                          child: SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: SvgPicture.asset(
                              itemSvgs[index - 1],
                              color: selectedIndex == index - 1
                                  ? colors(context).primaryColor
                                  : AppStaticColor.grayColor,
                            ),
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            onSelect(index);
                          },
                          child: SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: SvgPicture.asset(
                              itemSvgs[index],
                              color: selectedIndex == index
                                  ? colors(context).primaryColor
                                  : AppStaticColor.grayColor,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: SizedBox(
              width: 390.w,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35.h),
                  child: GestureDetector(
                    onTap: () {
                      onSelect(null);
                    },
                    child: Container(
                      height: 71.h,
                      width: 71.h,
                      padding: EdgeInsets.all(13.r),
                      decoration: const BoxDecoration(
                        color: AppStaticColor.whiteColor,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppStaticColor.grayColor,
                          borderRadius: BorderRadius.circular(35.h),
                        ),
                        child: SizedBox(
                          height: 20.h,
                          width: 20.h,
                          child: SvgPicture.asset(menuSvg),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<Box<HiveCartModel>>(
            valueListenable:
                Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
            builder: (context, cartBox, _) {
              final cartItems = cartBox.values.toList();
              return cartItems.isNotEmpty
                  ? Positioned(
                      top: 45,
                      left: 100,
                      right: 100,
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: colors(context).primaryColor,
                        child: Center(
                          child: Text(
                            cartItems.length.toString(),
                            style: textStyle.bodyText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppStaticColor.accentColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
    );
  }
}
