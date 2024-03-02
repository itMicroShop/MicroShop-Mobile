import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/custom_search_field.dart';

class OwnProductNavBar extends StatelessWidget {
  OwnProductNavBar({
    super.key,
    required this.bannerPath,
  });

  final String bannerPath;
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Stack(
        children: [
          SizedBox(
            height: 160.h,
            width: double.infinity,
            child: Image.asset(
              bannerPath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: 160.h,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppStaticColor.blackColor.withOpacity(0.1),
              AppStaticColor.blackColor.withOpacity(0.8),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      context.nav.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppStaticColor.accentColor,
                    ),
                  ),
                  SizedBox(
                    width: 220.w,
                    child: CustomSearchField(
                      hintText: S.of(context).searchProducts,
                      searchController: searchController,
                      onChanged: (value) {},
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: AppStaticColor.primaryColor,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.tune,
                          color: AppStaticColor.accentColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
