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
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/add_to_cart_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RelatedProductsCard extends ConsumerWidget {
  final List<Product> relatedProducts;
  const RelatedProductsCard({super.key, required this.relatedProducts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = AppTextStyle(context);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: relatedProducts.length,
      itemBuilder: (context, index) {
        final product = relatedProducts[index];
        return ValueListenableBuilder<Box<HiveCartModel>>(
          valueListenable: Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
          builder: (context, cartBox, _) {
            bool inCart = false;
            late int productQuantity;
            late int cartIndex;
            final cartItems = cartBox.values.toList();
            for (int i = 0; i < cartItems.length; i++) {
              final cartProduct = cartItems[i];
              if (cartProduct.id == product.id) {
                inCart = true;
                productQuantity = cartProduct.productsQTY;
                cartIndex = i;
                break;
              }
            }
            return Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 16.h),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  context.nav.pushNamed(Routes.productDetailsScreen,
                      arguments: relatedProducts[index].id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppStaticColor.whiteColor,
                    border: Border.all(
                      color: colors(context).bodyTextColor!.withOpacity(0.2),
                    ),
                  ),
                  padding: EdgeInsets.all(12.r),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: SizedBox(
                          height: 72.h,
                          width: 72.h,
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
                      12.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: textStyle.bodyTextSmall.copyWith(
                                color: AppStaticColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            2.ph,
                            Text(
                              product.shopName,
                              style: textStyle.bodyTextSmall.copyWith(
                                  color: AppStaticColor.grayColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.ph,
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '\$${product.price}/${product.sellType}',
                                    style: textStyle.bodyText.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppStaticColor.blackColor,
                                    ),
                                  ),
                                ),
                                inCart
                                    ? Row(
                                        children: [
                                          AppIconButton(
                                            size: 28.sp,
                                            iconData: Icons.remove,
                                            btnColor:
                                                colors(context).accentColor ??
                                                    AppStaticColor.accentColor,
                                            iconColor:
                                                AppStaticColor.blackColor,
                                            onTap: () {
                                              ref
                                                  .read(cartRepo)
                                                  .decrementProductQuantity(
                                                    productId: product.id,
                                                    cartBox: cartBox,
                                                    index: cartIndex,
                                                  );
                                            },
                                          ),
                                          5.pw,
                                          Text(
                                            productQuantity.toString(),
                                            style: textStyle.bodyTextSmall
                                                .copyWith(
                                              color: AppStaticColor.blackColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          5.pw,
                                          AppIconButton(
                                            size: 28.sp,
                                            btnColor:
                                                colors(context).primaryColor ??
                                                    AppStaticColor.primaryColor,
                                            iconData: Icons.add,
                                            onTap: () async {
                                              ref
                                                  .read(cartRepo)
                                                  .incrementProductQuantity(
                                                    productId: product.id,
                                                    box: cartBox,
                                                    index: cartIndex,
                                                  );
                                            },
                                          ),
                                        ],
                                      )
                                    : AddToCartButton(
                                        size: 28,
                                        onTap: () async {
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
                                                cartBox: cartBox,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
