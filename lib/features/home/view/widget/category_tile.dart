// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/features/categories/model/category.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final List<Category> catgoryList;
  final int index;
  final bool fromShop;
  const CategoryTile({
    Key? key,
    required this.category,
    required this.catgoryList,
    required this.index,
    required this.fromShop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return GestureDetector(
      onTap: () {
        if (fromShop) {
          context.nav.pushNamed(
            Routes.categoryScreen,
            arguments: CategoryArgument(
              categoryList: catgoryList,
              index: index,
              categoryId: category.id,
              shopId: fromShop ? category.shopId : null,
            ),
          );
        } else {
          context.nav
              .pushNamed(Routes.categoryWiseShop, arguments: category.id);
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(39.r),
            child: SizedBox(
              height: 78.h,
              width: 78.w,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: category.icon,
                placeholder: (context, url) => const Icon(Icons.image),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          8.ph,
          Text(
            category.name ?? '',
            overflow: TextOverflow.ellipsis,
            style:
                textStyle.bodyTextSmall.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class CategoryArgument {
  List<Category> categoryList;
  int index;
  int categoryId;
  int? shopId;
  CategoryArgument({
    required this.categoryList,
    required this.index,
    required this.categoryId,
    required this.shopId,
  });
}
