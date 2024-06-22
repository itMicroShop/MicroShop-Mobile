import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/menu/logic/menu_repo.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/features/menu/view/widgets/address_card.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';

class ManageAddressScreen extends ConsumerStatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  ConsumerState<ManageAddressScreen> createState() =>
      _ManageAddressScreenState();
}

class _ManageAddressScreenState extends ConsumerState<ManageAddressScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final textStyle = AppTextStyle(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors(context).primaryColor,
        onPressed: () {
          context.nav
              .pushNamed(Routes.addUserAddressScreen, arguments: null)
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: AppStaticColor.whiteColor,
        ),
      ),
      appBar: AppBar(
        title: Text(S.of(context).manageAddress),
      ),
      body: FutureBuilder(
        future: ref.read(menuRepo).getUserAddresses(),
        builder: (context, AsyncSnapshot<List<UserAddress>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                S.of(context).someThingWrong,
                style: textStyle.bodyText.copyWith(
                  color: AppStaticColor.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final List<UserAddress> userAddressList = snapshot.data ?? [];
            return userAddressList.isNotEmpty
                ? AnimationLimiter(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      itemCount: userAddressList.length,
                      itemBuilder: (context, index) {
                        final userAdress = userAddressList[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Stack(
                                  children: [
                                    AddressCard(
                                      userAddress: userAdress,
                                    ),
                                    Positioned(
                                      right: 14,
                                      top: 16,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: Size(50.w, 35.h),
                                          foregroundColor:
                                              colors(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.sp),
                                          ),
                                          side: BorderSide(
                                            color:
                                                colors(context).primaryColor ??
                                                    AppStaticColor.primaryColor,
                                          ),
                                        ),
                                        onPressed: () {
                                          context.nav
                                              .pushNamed(
                                            Routes.addUserAddressScreen,
                                            arguments: userAddressList[index],
                                          )
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        child: Center(
                                          child: Text(S.of(context).edit),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'Opps user address not found!',
                      style: textStyle.subTitle,
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
