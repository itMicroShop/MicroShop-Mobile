// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_input_decor.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/logic/cart_provider.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/features/cart/view/widget/address_selection_dialog.dart';
import 'package:grocerymart/features/cart/view/widget/cart_summary_text.dart';
import 'package:grocerymart/features/cart/view/widget/cart_tile.dart';
import 'package:grocerymart/features/checkout/model/place_order.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/features/menu/view/widgets/address_card.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/full_width_button_with_icon.dart';
import 'package:grocerymart/widgets/buttons/outlined_button.dart';
import 'package:grocerymart/widgets/custom_app_bar.dart';
import 'package:grocerymart/widgets/misc.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final TextEditingController couponController = TextEditingController();
  UserAddress? deliveryAddress;
  double couponDiscountAmount = 0;
  int? couponId;
  bool isCouponApply = false;

  List<double> previousSubtotals = [];
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    ref.read(hiveStorageProvider).getTheme().then((value) {
      setState(() {
        isDark = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    bool couponLoading = ref.watch(couponStateNotifierProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenWrapper(
        child: ValueListenableBuilder<Box<HiveCartModel>>(
          valueListenable: Hive.box<HiveCartModel>(AppHSC.cartBox).listenable(),
          builder: (context, box, _) {
            final cartItems = box.values.toList();
            final subTotal = calculateSubtotal(cartItems);
            // final oldPrice = calculateOldPrice(cartItems);
            final products = getProducts(cartItems);

            if (previousSubtotals.length == 2) {
              previousSubtotals.removeAt(0);
            }
            previousSubtotals.add(subTotal);

            double lastSubtotal = previousSubtotals.last;
            double secondLastSubTotal = previousSubtotals.first;

            if (lastSubtotal > secondLastSubTotal) {
              if (isCouponApply) {
                refreshCouponFunction(isHiveUpdate: true);
              }
            } else if (lastSubtotal < secondLastSubTotal) {
              if (isCouponApply) {
                refreshCouponFunction(isHiveUpdate: true);
              }
            }
            return cartItems.isNotEmpty
                ? Column(
                    children: [
                      CustomAppBar(
                        title:
                            '${S.of(context).cart} (${cartItems.length.toString()})',
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cartItems.length,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: CartTile(
                                cartItem: cartItems[index],
                                box: box,
                                index: index,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ListView(
                            padding: EdgeInsets.only(top: 8.0.h),
                            children: [
                              ValueListenableBuilder(
                                valueListenable:
                                    Hive.box(AppHSC.deliveryAddressBox)
                                        .listenable(),
                                builder: (context, addressBox, _) {
                                  Map<dynamic, dynamic>? address =
                                      addressBox.get(AppHSC.deliveryAddress);
                                  if (address != null) {
                                    Map<String, dynamic> addressStringKey =
                                        address.cast<String, dynamic>();
                                    deliveryAddress =
                                        UserAddress.fromMap(addressStringKey);
                                  }
                                  return deliveryAddress != null
                                      ? Column(
                                          children: [
                                            Stack(
                                              children: [
                                                AddressCard(
                                                  userAddress: deliveryAddress!,
                                                ),
                                                Positioned(
                                                  right: 14,
                                                  top: 16,
                                                  child: TextButton(
                                                    style: TextButton.styleFrom(
                                                      minimumSize:
                                                          Size(50.w, 30),
                                                      foregroundColor:
                                                          colors(context)
                                                              .primaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    18.sp),
                                                      ),
                                                      side: BorderSide(
                                                        color: colors(context)
                                                                .primaryColor ??
                                                            AppStaticColor
                                                                .primaryColor,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            const SelectAddressDialog(),
                                                      );
                                                    },
                                                    child: Center(
                                                      child: Text(
                                                          S.of(context).change),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.h),
                                          ],
                                        )
                                      : SizedBox(
                                          height: 50.h,
                                          child: TextButton.icon(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .all<Color>(AppStaticColor
                                                          .accentColor),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                colors(context).primaryColor ??
                                                    AppStaticColor.primaryColor,
                                              ),
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (builder) =>
                                                    const SelectAddressDialog(),
                                              );
                                            },
                                            icon: const Icon(Icons.add),
                                            label:
                                                Text(S.of(context).addAddress),
                                          ),
                                        );
                                },
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: couponController,
                                      onChanged: (v) {
                                        if (v.isEmpty) {
                                          refreshCouponFunction(
                                              isHiveUpdate: false);
                                        }
                                      },
                                      decoration: AppInputDecor
                                          .loginPageInputDecor
                                          .copyWith(
                                        prefixIcon: SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              Assets.svg.iconPercentage,
                                              fit: BoxFit.cover,
                                              color:
                                                  colors(context).primaryColor,
                                            ),
                                          ),
                                        ),
                                        hintText: S.of(context).enterPromoCode,
                                      ),
                                    ),
                                  ),
                                  10.pw,
                                  couponLoading
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w),
                                          child:
                                              const CircularProgressIndicator(),
                                        )
                                      : AppOutlinedButton(
                                          width: 100.w,
                                          height: 50.h,
                                          title: isCouponApply
                                              ? S.of(context).applied
                                              : S.of(context).apply,
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            if (!isCouponApply) {
                                              if (couponController
                                                  .text.isNotEmpty) {
                                                ref
                                                    .read(
                                                        couponStateNotifierProvider
                                                            .notifier)
                                                    .applyCouponCode(
                                                      shopId: cartItems
                                                          .first.shopId,
                                                      couponCode:
                                                          couponController.text,
                                                      amount: subTotal,
                                                    )
                                                    .then((coupon) {
                                                  if (coupon != null) {
                                                    isCouponApply = true;
                                                    couponDiscountAmount =
                                                        coupon.discount;
                                                    couponId = coupon.id;
                                                  }
                                                });
                                              } else {
                                                EasyLoading.showError(
                                                  S.of(context).pEnterPromoCode,
                                                );
                                              }
                                            }
                                          },
                                          buttonColor: Colors.transparent,
                                          borderWidth: isCouponApply ? 5 : 1,
                                          borderColor: isCouponApply
                                              ? AppStaticColor.accentColor
                                              : colors(context).primaryColor,
                                          titleColor: isCouponApply
                                              ? AppStaticColor.grayColor
                                              : colors(context).primaryColor,
                                        )
                                ],
                              ),
                              16.ph,
                              _cartSummaryWidget(
                                subTotal: subTotal,
                                discount: couponDiscountAmount,
                                deliveryCharge: 30.0,
                                payableAmount: payableAmount(
                                    subTotal: subTotal,
                                    deliveryCharge: 30,
                                    couponDiscountAmount: couponDiscountAmount),
                              ),
                              12.ph,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                color: colors(context).accentColor ??
                                    AppStaticColor.accentColor,
                                blurRadius: 2,
                              )
                            ]),
                        height: 96.h,
                        width: 390.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).total,
                                  style:
                                      textStyle.subTitle.copyWith(fontSize: 16),
                                ),
                                Text(
                                  '\$${payableAmount(subTotal: subTotal, deliveryCharge: 30, couponDiscountAmount: couponDiscountAmount)}',
                                  style: textStyle.subTitle,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 160.w,
                              height: 50,
                              child: AppTextButtonWithIcon(
                                onTap: () {
                                  CheckoutArgument checkoutArgument =
                                      CheckoutArgument(
                                    userAddress: deliveryAddress!,
                                    products: products,
                                    couponId: couponId,
                                    deliverCharge: 30,
                                    payable: payableAmount(
                                      subTotal: subTotal,
                                      deliveryCharge: 30,
                                      couponDiscountAmount:
                                          couponDiscountAmount,
                                    ),
                                    shopId: cartItems.first.shopId,
                                    cartBox: box,
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    Routes.checkoutScreen,
                                    arguments: checkoutArgument,
                                  );
                                },
                                title: S.of(context).checkOut,
                                icon: Icons.arrow_right_alt,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                : Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.images.emaptyCart.image(
                                height: 160.h,
                                width: 160.w,
                                color: colors(context).primaryColor),
                            SizedBox(height: 10.h),
                            Text(
                              'Oops!',
                              style: textStyle.subTitle.copyWith(
                                color: colors(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              S.of(context).yourCartIsEmpty,
                              style: textStyle.subTitle,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 20,
                        child: CircleAvatar(
                          radius: 25.r,
                          backgroundColor: isDark
                              ? AppStaticColor.accentColor
                              : AppStaticColor.blackColor,
                          child: IconButton(
                            onPressed: () {
                              context.nav.pop();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: isDark
                                  ? colors(context).primaryColor
                                  : AppStaticColor.accentColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _cartSummaryWidget({
    required double subTotal,
    required double discount,
    required double deliveryCharge,
    required double payableAmount,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppStaticColor.accentColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          CartSummaryText(
            title: S.of(context).subTotal,
            subTitle: '\$${subTotal.toStringAsFixed(2)}',
          ),
          12.ph,
          CartSummaryText(
            title: S.of(context).deliveryCharge,
            subTitle: '\$$deliveryCharge',
          ),
          12.ph,
          CartSummaryText(
            title: S.of(context).discount,
            subTitle: '-\$${discount.toStringAsFixed(2)}',
            isDicount: true,
          ),
          12.ph,
          AppCustomDivider(
            width: double.infinity,
            color: AppStaticColor.grayColor.withOpacity(0.2),
          ),
          12.ph,
          CartSummaryText(
            title: S.of(context).payableAmount,
            subTitle: '\$${payableAmount.toStringAsFixed(2)}',
            shouldBold: true,
          ),
        ],
      ),
    );
  }

  double calculateSubtotal(List<HiveCartModel> cartItems) {
    double subTotal = 0.0;
    for (var item in cartItems) {
      subTotal += item.price * item.productsQTY;
    }
    return subTotal;
  }

  double calculateOldPrice(List<HiveCartModel> cartItems) {
    double discount = 0.0;
    for (var item in cartItems) {
      discount += item.oldPrice * item.productsQTY;
    }
    return discount;
  }

  double payableAmount(
      {required double subTotal,
      required double deliveryCharge,
      required double couponDiscountAmount}) {
    return (subTotal + deliveryCharge) - couponDiscountAmount;
  }

  double discountAmount({
    required double oldPrice,
    required double subTotal,
    required double couponDiscountAmount,
  }) {
    if (oldPrice > subTotal) {
      return (oldPrice - subTotal) + couponDiscountAmount;
    } else {
      return couponDiscountAmount;
    }
  }

  List<Product> getProducts(List<HiveCartModel> cartItems) {
    List<Product> products = [];
    for (var item in cartItems) {
      Product product =
          Product(productId: item.id, productQTY: item.productsQTY);
      products.add(product);
    }
    return products;
  }

  refreshCouponFunction({required bool isHiveUpdate}) {
    if (isHiveUpdate) {
      isCouponApply = false;
      couponId = null;
      couponDiscountAmount = 0;
    } else {
      setState(() {
        isCouponApply = false;
        couponId = null;
        couponDiscountAmount = 0;
      });
    }
  }
}

class CheckoutArgument {
  UserAddress userAddress;
  List<Product> products;
  int? couponId;
  int deliverCharge;
  double payable;
  int shopId;
  Box<HiveCartModel> cartBox;
  CheckoutArgument({
    required this.userAddress,
    required this.products,
    this.couponId,
    required this.deliverCharge,
    required this.payable,
    required this.shopId,
    required this.cartBox,
  });
}
