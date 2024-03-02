import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_input_decor.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/top_nav_bar_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.showBack = true,
    this.title,
    this.trails,
    this.child,
    this.showCartIcon = false,
    this.showNotifIcon = false,
    this.showSearch = false,
    this.showSearchTextField = false,
    this.centerTitle = true,
    this.searchController,
    this.onPressed,
    this.readOnly = false,
  });
  final bool showBack;
  final String? title;
  final List<Widget>? trails;
  final Widget? child;
  final bool showCartIcon;
  final bool showNotifIcon;
  final bool showSearch;
  final bool centerTitle;
  final TextEditingController? searchController;
  final bool showSearchTextField;
  final void Function()? onPressed;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Container(
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: Column(
        children: [
          44.ph,
          Row(
            children: [
              if (showBack)
                GestureDetector(
                  onTap: () {
                    context.nav.pop();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 48.h,
                    width: 48.w,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        size: 24.sp,
                        color: colors(context).bodyTextSmallColor,
                      ),
                    ),
                  ),
                )
              else
                16.pw,
              Expanded(
                child: child ??
                    Text(
                      title ?? '',
                      style: textStyle.subTitle,
                      textAlign:
                          centerTitle ? TextAlign.center : TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
              16.pw,
              if (showSearch) ...[
                TopNavBarIconButton(
                  svgPath: Assets.svg.iconSearch,
                  onTap: onPressed,
                ),
                16.pw,
              ],
              if (showNotifIcon) ...[
                TopNavBarIconButton(
                  svgPath: Assets.svg.iconBell,
                  onTap: () {},
                ),
                16.pw,
              ],
              if (showCartIcon) ...[
                TopNavBarIconButton(
                  svgPath: Assets.svg.iconBasket,
                  onTap: () {
                    context.nav.pushNamed(Routes.cartScreen);
                  },
                ),
                16.pw,
              ],
              if (trails != null) ...[
                ...trails!,
                16.pw,
              ],
            ],
          ),
          12.ph,
          if (showSearchTextField) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FormBuilderTextField(
                onTap: onPressed,
                readOnly: readOnly,
                name: 'search',
                decoration: AppInputDecor.loginPageInputDecor.copyWith(
                  hintText: S.of(context).searchProducts,
                  hintStyle: textStyle.bodyTextSmall.copyWith(
                    color: AppStaticColor.grayColor.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                textInputAction: TextInputAction.next,
                controller: searchController,
              ),
            ),
            12.ph
          ],
        ],
      ),
    );
  }
}
