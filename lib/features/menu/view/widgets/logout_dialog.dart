import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/auth/logic/auth_provider.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/util/context_less_nav.dart';

class LogoutDialog extends ConsumerStatefulWidget {
  const LogoutDialog({super.key});

  @override
  ConsumerState<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends ConsumerState<LogoutDialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 20.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.sp),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color:
                    colors(context).accentColor ?? AppStaticColor.accentColor,
                blurRadius: 2.r,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.help,
                size: 50.sp,
                color: colors(context).primaryColor,
              ),
              SizedBox(height: 20.h),
              Text(
                S.of(context).logutConfirmation,
                style: textStyle.bodyText.copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      context.nav.pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          colors(context).primaryColor ??
                              AppStaticColor.primaryColor),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        AppStaticColor.accentColor,
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(80.w, 35.h),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set your desired border radius here
                        ),
                      ),
                    ),
                    child: Text(
                      S.of(context).cancel,
                      style: textStyle.bodyText.copyWith(
                        color: AppStaticColor.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 80.w,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: colors(context).primaryColor),
                          )
                        : TextButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await ref
                                  .read(authStateNotifierProvider.notifier)
                                  .logout()
                                  .then((isSuccess) {
                                if (isSuccess) {
                                  ref.read(hiveStorageProvider).removeAllData();
                                  context.nav.pushNamedAndRemoveUntil(
                                    Routes.login,
                                    (route) => false,
                                  );
                                }
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                AppStaticColor.accentColor,
                              ),
                              minimumSize: MaterialStateProperty.all(
                                Size(80.w, 35.h),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 2.sp,
                                      color: AppStaticColor.primaryColor),
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                S.of(context).okay,
                                style: textStyle.bodyText.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
