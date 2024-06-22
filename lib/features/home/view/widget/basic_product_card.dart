// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/logic/cart_repo.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/features/cart/view/widget/cart_remove_dialog.dart';
import 'package:grocerymart/features/home/model/product.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/add_to_cart_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BasicProductCard extends StatelessWidget {
  final Product product;
  final Color? cardColor;
  const BasicProductCard({
    Key? key,
    required this.product,
    this.cardColor = AppStaticColor.whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return ValueListenableBuilder<Box<HiveCartModel>>(
      valueListenable: Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
      builder: (context, box, _) {
        bool inCart = false;
        late int productQuantity;
        late int index;
        final cartItems = box.values.toList();
        for (int i = 0; i < cartItems.length; i++) {
          final cartProduct = cartItems[i];
          if (cartProduct.id == product.id) {
            inCart = true;
            productQuantity = cartProduct.productsQTY;
            index = i;
            break;
          }
        }

        return AbsorbPointer(
          absorbing: product.inStock == false,
          child: GestureDetector(
            onTap: () {
              context.nav.pushNamed(Routes.productDetailsScreen,
                  arguments: product.id);
            },
            child: Consumer(
              builder: (context, ref, _) {
                return Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppStaticColor.grayColor.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: SizedBox(
                              height: 105.h,
                              width: 147.w,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: product.thumbnail,
                                placeholder: (context, url) =>
                                    const Icon(Icons.image),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.h),
                                Text(
                                  product.shopName,
                                  style: textStyle.bodyTextSmall.copyWith(
                                    fontSize: 12.sp,
                                    color: AppStaticColor.grayColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5.0.h),
                                Text(
                                  product.name,
                                  style: textStyle.bodyTextSmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppStaticColor.blackColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5.h),
                                priceWidget(context),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${product.minimumQuantity.toString()} ${product.sellType}",
                                      style: textStyle.bodyTextSmall.copyWith(
                                          fontSize: 12.sp,
                                          color: AppStaticColor.grayColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    inCart
                                        ? Row(
                                            children: [
                                              AppIconButton(
                                                size: 28.sp,
                                                iconData: Icons.remove,
                                                btnColor:
                                                    AppStaticColor.whiteColor,
                                                iconColor:
                                                    AppStaticColor.blackColor,
                                                onTap: () {
                                                  ref
                                                      .read(cartRepo)
                                                      .decrementProductQuantity(
                                                        productId: product.id,
                                                        cartBox: box,
                                                        index: index,
                                                      );
                                                },
                                              ),
                                              5.pw,
                                              Text(productQuantity.toString(),
                                                  style: textStyle.bodyTextSmall
                                                      .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppStaticColor
                                                        .blackColor,
                                                  )),
                                              5.pw,
                                              AppIconButton(
                                                size: 28.sp,
                                                btnColor: colors(context)
                                                        .primaryColor ??
                                                    AppStaticColor.primaryColor,
                                                iconData: Icons.add,
                                                onTap: () {
                                                  ref
                                                      .read(cartRepo)
                                                      .incrementProductQuantity(
                                                        productId: product.id,
                                                        box: box,
                                                        index: index,
                                                      );
                                                },
                                              ),
                                            ],
                                          )
                                        : AddToCartButton(
                                            size: 28.sp,
                                            onTap: () async {
                                              final cartBox =
                                                  Hive.box<HiveCartModel>(
                                                      AppHSC.cartBox);
                                              HiveCartModel cartItem =
                                                  HiveCartModel(
                                                id: product.id,
                                                shopId: product.shopId,
                                                name: product.name,
                                                productImage: product.thumbnail,
                                                price: product.price,
                                                oldPrice: product.oldPrice,
                                                productsQTY: 1,
                                              );
                                              if (cartItems.isEmpty ||
                                                  cartItems.any((item) =>
                                                      item.shopId ==
                                                      product.shopId)) {
                                                await cartBox.add(cartItem);
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      CartRemoveDialog(
                                                    cartBox: box,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    product.inStock == false
                        ? Container(
                            decoration: BoxDecoration(
                              color:
                                  AppStaticColor.accentColor.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color:
                                    AppStaticColor.grayColor.withOpacity(0.1),
                              ),
                            ),
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 40.w),
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.sp),
                                  border: Border.all(
                                    width: 1,
                                    color: colors(context).primaryColor ??
                                        AppStaticColor.primaryColor,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).outOfStock,
                                    style: textStyle.bodyTextSmall.copyWith(
                                      color: colors(context).primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    product.inStock && product.discountPercentage != '0'
                        ? Positioned(
                            top: 10.h,
                            child: Container(
                              height: 25.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                                color: colors(context).primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  product.discountPercentage,
                                  style: textStyle.bodyTextSmall.copyWith(
                                      color: AppStaticColor.whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget priceWidget(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return product.oldPrice != 0
        ? RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'USH ${product.price.toStringAsFixed(2)} ',
                  style: textStyle.bodyTextSmall.copyWith(
                      color: colors(context).primaryColor,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text: product.oldPrice.toStringAsFixed(2),
                  style: textStyle.bodyTextSmall.copyWith(
                    fontSize: 12.sp,
                    color: AppStaticColor.grayColor,
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              ],
            ),
          )
        : Text('\$ ${product.price.toStringAsFixed(2)}');
  }
}
