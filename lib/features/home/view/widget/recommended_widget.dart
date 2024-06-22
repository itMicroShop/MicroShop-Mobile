// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/features/home/view/widget/basic_product_card.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';

class RecommendedWidget extends ConsumerWidget {
  final List<dynamic> products;

  const RecommendedWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

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
              blurRadius: 5,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).recommendedProduct,
                style: textStyle.subTitle,
              ),
              GestureDetector(
                onTap: () {
                  context.nav
                      .pushNamed(Routes.ownProductScreen, arguments: products);
                },
                child: Text(
                  S.of(context).viewAll,
                  style: textStyle.bodyText.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colors(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
          products.isNotEmpty
              ? AnimationLimiter(
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10.h),
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 171.w / 250.h,
                    children: List.generate(
                      products.length < 4 ? products.length : 4,
                      (index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: BasicProductCard(
                                product: products[index],
                                cardColor: colors(context).accentColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      S.of(context).noProductFound,
                      style: textStyle.subTitle,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
