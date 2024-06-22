import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/view/cart_view.dart';
import 'package:grocerymart/features/checkout/logic/order_provider.dart';
import 'package:grocerymart/features/checkout/model/place_order.dart';
import 'package:grocerymart/features/checkout/view/widget/confirm_dialog.dart';
import 'package:grocerymart/features/menu/view/widgets/address_card.dart';
import 'package:grocerymart/features/payment/logic/payment_repo.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';
import 'package:grocerymart/widgets/custom_app_bar.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final CheckoutArgument checkoutArgument;
  const CheckoutScreen({
    super.key,
    required this.checkoutArgument,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckoutScreenState();
}

final TextEditingController additionalInfoController = TextEditingController();

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _paymentMethod = '';
  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(orderStateNotifierProvider);
    return ScreenWrapper(
      child: Column(
        children: [
          CustomAppBar(
            title: S.of(context).checkOut,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  children: [
                    AddressCard(
                      userAddress: widget.checkoutArgument.userAddress,
                    ),
                    15.ph,
                    _buiildInfoField(),
                    15.ph,
                    _buildPaymentCard()
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color:
                      colors(context).accentColor ?? AppStaticColor.accentColor,
                  blurRadius: 3,
                ),
              ],
            ),
            height: 96.h,
            width: 390.w,
            child: Row(
              children: [
                Expanded(
                  child: isLoading
                      ? SizedBox(
                          height: 100.h,
                          width: 100.w,
                          child: const BusyLoader(),
                        )
                      : ref.watch(paymentRepo).isLoading
                          ? SizedBox(
                              height: 100.h,
                              width: 100.w,
                              child: const BusyLoader(),
                            )
                          : SizedBox(
                              height: 50.h,
                              child: AppTextButton(
                                title: S.of(context).placeOrder,
                                onTap: () async {
                                  if (_paymentMethod != '') {
                                    PlaceOrderModel orderData = PlaceOrderModel(
                                      shopId: widget.checkoutArgument.shopId,
                                      addressId: widget
                                          .checkoutArgument.userAddress.id!,
                                      paymentMethod: _paymentMethod,
                                      product: widget.checkoutArgument.products,
                                      note: additionalInfoController.text,
                                      deliveryCharge:
                                          widget.checkoutArgument.deliverCharge,
                                      couponId:
                                          widget.checkoutArgument.couponId,
                                      paymentVia: 'cash',
                                    );
                                    await ref
                                        .read(
                                            orderStateNotifierProvider.notifier)
                                        .placeOrder(orderData: orderData)
                                        .then(
                                      (orderId) async {
                                        widget.checkoutArgument.cartBox.clear();
                                        if (orderId == null) {
                                          debugPrint('order id null');
                                        } else {
                                          if (_paymentMethod == 'online') {
                                            await ref
                                                .read(paymentRepo)
                                                .stripePayment(
                                                  amount: widget
                                                      .checkoutArgument.payable
                                                      .toInt(),
                                                  orderId: orderId,
                                                  cartBox: widget
                                                      .checkoutArgument.cartBox,
                                                );
                                          } else {
                                            return showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (builder) =>
                                                  ConfirmDialog(
                                                cartBox: widget
                                                    .checkoutArgument.cartBox,
                                                orderId: orderId,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                    );
                                  } else {
                                    EasyLoading.showError(
                                      S.of(context).selectPaymentMethod,
                                    );
                                  }
                                },
                              ),
                            ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buiildInfoField() {
    return Container(
      height: 112.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
        ),
      ),
      child: TextField(
        controller: additionalInfoController,
        maxLines: 5,
        style: TextStyle(fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: S.of(context).additionalInfo,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: Colors.black.withOpacity(0.4),
          ),
          fillColor: AppStaticColor.accentColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.h),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.r),
                  topRight: Radius.circular(10.r)),
            ),
            child: Row(
              children: [
                const Icon(Icons.payment),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    S.of(context).toBePaid,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                Text(
                  'USH ${widget.checkoutArgument.payable.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Radio(
              value: 'cash',
              groupValue: _paymentMethod,
              activeColor: colors(context).primaryColor,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            title: Text(
              S.of(context).cashOnDelivery,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Radio(
              value: 'online',
              groupValue: _paymentMethod,
              activeColor: colors(context).primaryColor,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            title: Text(
              S.of(context).card,
              style: TextStyle(fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }
}
