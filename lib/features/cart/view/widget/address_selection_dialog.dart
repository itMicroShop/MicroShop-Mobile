import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/menu/logic/menu_provider.dart';
import 'package:grocerymart/features/menu/model/user_address.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/util/context_less_nav.dart';
import 'package:grocerymart/widgets/busy_loader.dart';

class SelectAddressDialog extends ConsumerStatefulWidget {
  const SelectAddressDialog({super.key});

  @override
  ConsumerState<SelectAddressDialog> createState() =>
      _SelectAddressDialogState();
}

class _SelectAddressDialogState extends ConsumerState<SelectAddressDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressList();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(menuStateNotifierProvider);
    final textStyle = AppTextStyle(context);
    return Dialog(
      shadowColor: colors(context).accentColor,
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
            constraints: BoxConstraints(
              maxHeight: 320.h,
              maxWidth: 320.w,
              minHeight: 320.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color:
                      colors(context).accentColor ?? AppStaticColor.accentColor,
                  blurRadius: 1,
                )
              ],
            ),
            child: Scrollbar(
              thumbVisibility: true,
              thickness: 10.sp,
              radius: Radius.circular(10.sp),
              child: isLoading
                  ? Center(
                      child: SizedBox(
                        height: 200.h,
                        child: Center(
                          child: SizedBox(
                            height: 100.h,
                            width: 100.w,
                            child: const BusyLoader(),
                          ),
                        ),
                      ),
                    )
                  : addressList.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Address Found!',
                              style: textStyle.subTitle,
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: TextButton.icon(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppStaticColor.accentColor),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    colors(context).primaryColor ??
                                        AppStaticColor.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  context.nav.pop();
                                  context.nav.pushNamed(
                                    Routes.addUserAddressScreen,
                                    arguments: null,
                                  );
                                },
                                icon: const Icon(Icons.add),
                                label: const Text('Add Address'),
                              ),
                            ),
                          ],
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 20),
                          shrinkWrap: true,
                          itemCount: addressList.length,
                          itemBuilder: (context, index) {
                            UserAddress address = addressList[index];
                            return ListTile(
                              onTap: () {
                                ref
                                    .read(hiveStorageProvider)
                                    .saveDeliveryAddress(userAddress: address);
                                context.nav.pop();
                              },
                              leading: CircleAvatar(
                                radius: 20.sp,
                                child: Text(
                                  addressList[index].name[0],
                                ),
                              ),
                              title: Text(
                                addressList[index].name,
                                style:
                                    textStyle.subTitle.copyWith(fontSize: 14),
                              ),
                              subtitle: Text(
                                '${address.area}, ${address.flat}, ${address.addressLine1}, ${address.addressLine2}-${address.postCode}',
                                style:
                                    textStyle.subTitle.copyWith(fontSize: 14),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Divider(
                            color: colors(context).bodyTextColor,
                          ),
                        ),
            ),
          ),
          addressList.isNotEmpty
              ? Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: colors(context).accentColor,
                    child: IconButton(
                      splashRadius: 30,
                      onPressed: () {
                        context.nav.pop();
                        context.nav.pushNamed(
                          Routes.addUserAddressScreen,
                          arguments: null,
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: colors(context).primaryColor,
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  List<UserAddress> addressList = [];
  Future<void> getAddressList() async {
    ref
        .read(menuStateNotifierProvider.notifier)
        .getUserAddresses()
        .then((address) {
      addressList.addAll(address);
    });
  }
}
