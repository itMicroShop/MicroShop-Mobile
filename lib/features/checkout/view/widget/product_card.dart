// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/checkout/model/order_details.dart';
import 'package:grocerymart/generated/l10n.dart';

class ProductCardWidget extends StatefulWidget {
  final List<OrderProduct> products;
  const ProductCardWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: colors(context).accentColor,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${S.of(context).items}(${widget.products.length})',
                    style: textStyle.bodyTextSmall.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppStaticColor.blackColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: isExpanded ? double.infinity : 0,
                  ),
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 300),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    firstChild: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5.r),
                          child: CachedNetworkImage(
                            width: 70.w,
                            fit: BoxFit.cover,
                            imageUrl: widget.products[index].thumbnail,
                            placeholder: (context, url) =>
                                const Icon(Icons.image),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        title: Text(
                          widget.products[index].name,
                          style: textStyle.bodyTextSmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppStaticColor.blackColor,
                          ),
                        ),
                        subtitle: Wrap(
                          children: [
                            Text(widget.products[index].quantity.toString()),
                            const Icon(
                              Icons.close,
                              size: 20,
                            ),
                            Text('\$${widget.products[index].price}')
                          ],
                        ),
                        trailing: Text(
                          '\$${widget.products[index].price * widget.products[index].quantity}',
                          style: textStyle.bodyText.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppStaticColor.blackColor,
                          ),
                        ),
                      ),
                    ),
                    secondChild: Container(),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
