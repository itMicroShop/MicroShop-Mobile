import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/features/auth/logic/auth_provider.dart';
import 'package:grocerymart/features/auth/view/widget/build_textfield.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String token;
  const ChangePasswordScreen({super.key, required this.token});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final List<FocusNode> focusNode = [FocusNode(), FocusNode()];

  bool showPass = false;
  bool showConPass = false;
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authStateNotifierProvider);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: FormBuilder(
          key: _formkey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).createNewPass,
                    style: AppTextStyle(context).title,
                  ),
                  SizedBox(height: 26.h),
                  Text(
                    S.of(context).newPassDes,
                    style: AppTextStyle(context)
                        .bodyTextSmall
                        .copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  CustomTextFormField(
                    focusNode: focusNode[0],
                    name: 'password',
                    hintText: S.of(context).password,
                    controller: passController,
                    textInputType: TextInputType.text,
                    obscureText: !showPass,
                    widget: GestureDetector(
                      onTap: () {
                        setState(() {
                          showPass = !showPass;
                        });
                      },
                      child: Icon(
                          showPass ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomTextFormField(
                    focusNode: focusNode[1],
                    name: 'confirm password',
                    hintText: S.of(context).confirmPassword,
                    controller: confirmPassController,
                    textInputType: TextInputType.text,
                    obscureText: !showConPass,
                    widget: GestureDetector(
                      onTap: () {
                        setState(() {
                          showConPass = !showConPass;
                        });
                      },
                      child: Icon(showConPass
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  SizedBox(height: 60.h),
                  SizedBox(
                    height: 50.h,
                    child: isLoading
                        ? const Center(
                            child: BusyLoader(),
                          )
                        : AppTextButton(
                            title: S.of(context).setPass,
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                ref
                                    .read(authStateNotifierProvider.notifier)
                                    .changePassword(
                                      password: passController.text.trim(),
                                      confirmPass:
                                          confirmPassController.text.trim(),
                                      token: widget.token,
                                    )
                                    .then((respoonse) {
                                  if (respoonse.isSuccess) {
                                    EasyLoading.showSuccess(respoonse.message);
                                    return Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.login,
                                        (route) => false);
                                  }
                                });
                              }
                              FocusScope.of(context).unfocus();
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
