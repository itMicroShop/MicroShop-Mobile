import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/checkout/logic/order_repo.dart';
import 'package:grocerymart/features/checkout/model/order.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/context_less_nav.dart';
import 'package:grocerymart/widgets/busy_loader.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = AppTextStyle(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(S.of(context).orders),
      ),
      body: FutureBuilder(
        future: ref.read(orderRepo).getOrders(),
        builder: (context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                S.of(context).someThingWrong,
                style: textStyle.subTitle,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Order> data = snapshot.data ?? [];

            final List<Order> orders = data.reversed.toList();
            if (orders.isEmpty) {
              return Center(
                child: Text(
                  S.of(context).orderNotFound,
                  style: textStyle.subTitle,
                ),
              );
            }
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: ((context, index) =>
                    AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: AppStaticColor.accentColor,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                onTap: () {
                                  context.nav.pushNamed(
                                    Routes.orderDetails,
                                    arguments: orders[index].id,
                                  );
                                },
                                leading: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: orders[index].shopLogo,
                                  placeholder: (context, url) =>
                                      const Icon(Icons.image),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                title: Text(
                                  '${S.of(context).orderId}: #000${orders[index].id}',
                                  style: textStyle.bodyTextSmall.copyWith(
                                    color: AppStaticColor.blackColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(orders[index].shopName),
                                trailing: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.sp),
                                    color: orders[index].status == 'pending' ||
                                            orders[index].status == 'cancel'
                                        ? colors(context)
                                            .primaryColor!
                                            .withOpacity(0.2)
                                        : Colors.green.withOpacity(0.2),
                                  ),
                                  child: Text(
                                    orders[index].status,
                                    style: textStyle.bodyTextSmall.copyWith(
                                      color: AppStaticColor.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
            );
          }
          return _buildLoader(context);
        },
      ),
    );
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
