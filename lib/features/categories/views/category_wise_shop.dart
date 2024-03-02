import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/shop/logic/shop_provider.dart';
import 'package:grocerymart/features/shop/model/shop.dart';
import 'package:grocerymart/features/shop/view/widget/seller_card.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/widgets/busy_loader.dart';

class CategoryWiseShop extends ConsumerStatefulWidget {
  final int categoryId;
  const CategoryWiseShop({
    super.key,
    required this.categoryId,
  });

  @override
  ConsumerState<CategoryWiseShop> createState() => _CategoryWiseShopState();
}

class _CategoryWiseShopState extends ConsumerState<CategoryWiseShop> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getShopList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    bool isLoading = ref.watch(shopNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shop),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 100.h,
                width: 100.w,
                child: const BusyLoader(),
              ),
            )
          : _categoryWiseShops.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).shopNotfound,
                    style: textStyle.bodyText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppStaticColor.blackColor,
                    ),
                  ),
                )
              : AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100.h),
                    itemCount: _categoryWiseShops.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 8.h),
                              child: SellerCard(
                                shop: _categoryWiseShops[index],
                                cardColor: colors(context).accentColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  final List<Shop> _categoryWiseShops = [];

  Future<void> getShopList() async {
    await ref
        .read(shopNotifierProvider.notifier)
        .getShopList(
          latitude: null,
          longitude: null,
          categoryId: widget.categoryId,
          count: 1,
          shopCount: 10,
        )
        .then((response) {
      _categoryWiseShops.addAll(response.shopList);
    });
  }
}
