// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/checkout/logic/order_provider.dart';
import 'package:grocerymart/features/checkout/logic/order_repo.dart';
import 'package:grocerymart/features/checkout/model/order.dart';
import 'package:grocerymart/features/checkout/model/order_details.dart';
import 'package:grocerymart/features/checkout/view/widget/product_card.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  final int orderId;
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    bool isLoading = ref.watch(orderStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).orderDetails,
        ),
      ),
      body: FutureBuilder(
        future: ref.read(orderRepo).getOrderDetails(orderId: widget.orderId),
        builder: (context, AsyncSnapshot<OrderDetails> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text(
                  S.of(context).someThingWrong,
                  style: textStyle.bodyTextSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppStaticColor.blackColor,
                  ),
                ),
              );
            }
            final orderDetails = snapshot.data;
            if (orderDetails != null) {
              final Order order = orderDetails.order;
              final ShippingAddress shippingAddress =
                  orderDetails.shippingAddress;
              final List<OrderProduct> products = orderDetails.products;

              return SingleChildScrollView(
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 375),
                      childAnimationBuilder: (widget) =>
                          SlideAnimation(horizontalOffset: 50.0, child: widget),
                      children: [
                        ProductCardWidget(products: products),
                        buildAddressCard(address: shippingAddress),
                        buildDetailsCard(orderInfo: order),
                        SizedBox(height: 120.h),
                        order.status == 'pending'
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.0),
                                child: isLoading
                                    ? const BusyLoader()
                                    : SizedBox(
                                        height: 50.h,
                                        child: AppTextButton(
                                          buttonColor: AppStaticColor.grayColor,
                                          title: S.of(context).cancelOrder,
                                          onTap: () {
                                            ref
                                                .read(orderStateNotifierProvider
                                                    .notifier)
                                                .cancelOrder(orderId: order.id)
                                                .then(
                                                  (message) =>
                                                      EasyLoading.showSuccess(
                                                          message!),
                                                );
                                          },
                                        ),
                                      ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
          return _buildLoader(context);
        },
      ),
    );
  }

  Widget buildAddressCard({required ShippingAddress address}) {
    final textStyle = AppTextStyle(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: colors(context).accentColor,
      ),
      child: Column(
        children: [
          buildCardHeader(addressName: address.addressName),
          SizedBox(height: 5.h),
          SizedBox(
            child: Padding(
              padding: EdgeInsets.only(left: 35.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: textStyle.bodyText.copyWith(
                      color: AppStaticColor.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    address.phone,
                    style: textStyle.bodyText.copyWith(
                      color: AppStaticColor.blackColor,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    '${address.area}, ${address.flat}, ${address.lineOne}, ${address.lineTwo}-${address.postCode}',
                    style: textStyle.bodyTextSmall.copyWith(
                      color: AppStaticColor.blackColor,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildDetailsCard({required Order orderInfo}) {
    final textStyle = AppTextStyle(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: colors(context).accentColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).orderId,
                style: textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '#000${orderInfo.id}',
                style: textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          buildTile(
            key: S.of(context).orderStatus,
            value: getStatus(orderInfo.status),
          ),
          SizedBox(height: 10.h),
          buildTile(
            key: S.of(context).paymentStatus,
            value: getStatus(
              orderInfo.paymentStatus,
            ),
          ),
          SizedBox(height: 10.h),
          buildTile(
              key: S.of(context).subTotal, value: 'USH ${orderInfo.subTotal}'),
          SizedBox(height: 10.h),
          buildTile(
              key: S.of(context).deliveryCharge,
              value: 'USH ${orderInfo.deliveryCharge}'),
          SizedBox(height: 10.h),
          buildTile(
              key: S.of(context).discount, value: 'USH ${orderInfo.discount}'),
          SizedBox(height: 10.h),
          const DottedLine(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            lineLength: double.infinity,
            lineThickness: 1.0,
            dashLength: 8.0,
            dashColor: AppStaticColor.blackColor,
            dashRadius: 0.0,
            dashGapLength: 5.0,
            dashGapColor: AppStaticColor.accentColor,
            dashGapRadius: 0.0,
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).total,
                style: textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'USH ${orderInfo.total}',
                style: textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildTile({required String key, required String value}) {
    final textStyle = AppTextStyle(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: textStyle.bodyTextSmall.copyWith(
            color: AppStaticColor.blackColor,
          ),
        ),
        Text(
          value,
          style: textStyle.bodyTextSmall.copyWith(
            color: AppStaticColor.blackColor,
          ),
        )
      ],
    );
  }

  Widget buildCardHeader({required String addressName}) {
    final textStyle = AppTextStyle(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Assets.images.locationPin.image(width: 30.sp),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: AppStaticColor.blackColor,
              ),
              child: Center(
                child: Text(
                  getAddressTag(addressName).toUpperCase(),
                  style: textStyle.bodyText.copyWith(
                    color: AppStaticColor.whiteColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: AppStaticColor.grayColor,
          ),
          child: Text(
            S.of(context).Shipping,
            style: textStyle.bodyTextSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: AppStaticColor.whiteColor,
            ),
          ),
        )
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

  String getStatus(String status) {
    if (status == "pending") {
      return S.of(context).pending;
    } else if (status == "confirm") {
      return S.of(context).confirm;
    } else {
      return S.of(context).cancel;
    }
  }

  _buildLoader(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxHeight: 120.h, minWidth: 100.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: colors(context).accentColor),
        width: 200,
        child: const BusyLoader(
          size: 120,
        ),
      ),
    );
  }
}
