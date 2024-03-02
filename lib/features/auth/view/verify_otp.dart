// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/features/auth/logic/auth_provider.dart';
import 'package:grocerymart/features/auth/view/widget/pin_put.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';
import 'package:pinput/pinput.dart';

class VerifyOTPScreen extends ConsumerStatefulWidget {
  final VerifyOTPArgument argument;
  const VerifyOTPScreen({super.key, required this.argument});

  @override
  ConsumerState<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends ConsumerState<VerifyOTPScreen> {
  final TextEditingController pinCodeController = TextEditingController();

  Timer? timer;
  int start = 60;

  @override
  void initState() {
    pinCodeController.text = widget.argument.data.toString();
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authStateNotifierProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.checkOtp.image(width: 80.w),
                SizedBox(height: 40.h),
                Text(
                  S.of(context).enterOTP,
                  style: AppTextStyle(context).title,
                ),
                SizedBox(height: 12.h),
                Text(
                  " ${S.of(context).verifyOTPDes}\n ${widget.argument.contact}",
                  style: AppTextStyle(context)
                      .bodyTextSmall
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: PinPutWidget(
                    pinCodeController: pinCodeController,
                    onCompleted: (pin) {},
                    validator: (value) {
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                SizedBox(
                  height: 50.h,
                  child: AppTextButton(
                    title: S.of(context).confirmOTP,
                    onTap: () async {
                      print(pinCodeController.text);
                      if (pinCodeController.length == 4) {
                        ref
                            .read(authStateNotifierProvider.notifier)
                            .verifyOTP(
                              contact: widget.argument.contact,
                              otp: pinCodeController.text,
                            )
                            .then((response) {
                          if (response.isSuccess) {
                            FocusScope.of(context).unfocus();
                            if (widget.argument.isPassRecover) {
                              return Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.changePasswordScreen,
                                arguments: response.message,
                                (route) => false,
                              );
                            } else {
                              return Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.dashboard,
                                (route) => false,
                              );
                            }
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 52.h),
                start == 0
                    ? isLoading
                        ? const Center(
                            child: BusyLoader(),
                          )
                        : TextButton(
                            onPressed: () {
                              ref
                                  .read(authStateNotifierProvider.notifier)
                                  .sendOTP(contact: widget.argument.contact)
                                  .then((response) {
                                pinCodeController.text =
                                    response.data.toString();
                              });
                              setState(() {
                                start = 60;
                              });
                              startTimer();
                            },
                            child: Text(
                              S.of(context).resendCode,
                              style: AppTextStyle(context).bodyText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppStaticColor.primaryColor),
                            ),
                          )
                    : Text(
                        "${S.of(context).resend} 00:$start ${S.of(context).sec}",
                        style: AppTextStyle(context)
                            .bodyTextSmall
                            .copyWith(fontWeight: FontWeight.w500),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}

class VerifyOTPArgument {
  final String contact;
  final bool isPassRecover;
  int? data;
  VerifyOTPArgument({
    required this.contact,
    required this.isPassRecover,
    this.data,
  });
}
