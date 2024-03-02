import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/auth/logic/auth_provider.dart';
import 'package:grocerymart/features/auth/logic/auth_repo.dart';
import 'package:grocerymart/features/auth/model/sign_up.dart';
import 'package:grocerymart/features/auth/view/verify_otp.dart';
import 'package:grocerymart/features/auth/view/widget/auth_wrapper.dart';
import 'package:grocerymart/features/auth/view/widget/build_textfield.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController firstNameControler = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  final List<FocusNode> fNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  final ScrollController _scrollController = ScrollController();

  bool showPass = false;
  bool showConfirmPassword = false;
  bool isLoading = true;
  bool isVerification = true;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    final isLoading = ref.watch(authStateNotifierProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AuthWrapper(
          child: FormBuilder(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.only(
            bottom: 20.h,
            left: 24.w,
            right: 24.w,
          ),
          controller: _scrollController,
          children: [
            SizedBox(height: 20.h),
            SvgPicture.asset(
              Assets.svg.appLogo,
              width: 150.w,
            ),
            CustomTextFormField(
              name: 'first name',
              focusNode: fNodes[0],
              hintText: S.of(context).firstName,
              textInputType: TextInputType.text,
              controller: firstNameControler,
            ),
            8.ph,
            CustomTextFormField(
              name: 'last name',
              focusNode: fNodes[1],
              hintText: S.of(context).lastName,
              textInputType: TextInputType.text,
              controller: lastNameController,
            ),
            10.ph,
            CustomTextFormField(
              name: 'email',
              focusNode: fNodes[2],
              hintText: S.of(context).email,
              textInputType: TextInputType.text,
              controller: emailController,
            ),
            10.ph,
            CustomTextFormField(
              name: 'phone number',
              focusNode: fNodes[3],
              hintText: S.of(context).phoneNumber,
              textInputType: TextInputType.number,
              controller: phoneNumController,
            ),
            10.ph,
            CustomTextFormField(
              name: 'password',
              obscureText: !showPass,
              focusNode: fNodes[4],
              hintText: S.of(context).password,
              textInputType: TextInputType.text,
              controller: passwordController,
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
                child: Icon(showPass ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            10.ph,
            CustomTextFormField(
              name: 'confirm password',
              obscureText: !showConfirmPassword,
              focusNode: fNodes[5],
              hintText: S.of(context).confirmPassword,
              textInputType: TextInputType.text,
              controller: confPassController,
              widget: GestureDetector(
                onTap: () {
                  setState(() {
                    showConfirmPassword = !showConfirmPassword;
                  });
                },
                child: Icon(showConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
            28.ph,
            isLoading
                ? const SizedBox(height: 100, width: 100, child: BusyLoader())
                : SizedBox(
                    height: 50.h,
                    child: AppTextButton(
                      title: S.of(context).signUp,
                      onTap: () async {
                        if (_formkey.currentState!.validate()) {
                          SignUpCredential signUpCredential = SignUpCredential(
                            firstName: firstNameControler.text,
                            lastName: lastNameController.text,
                            phoneNumber: phoneNumController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confPassController.text,
                          );

                          final nav = context.nav;
                          final bool isSuccess =
                              await performSignUp(ref, signUpCredential);
                          if (isSuccess) {
                            if (isVerification) {
                              ref
                                  .read(authService)
                                  .sendOTP(contact: emailController.text.trim())
                                  .then((response) {
                                nav.pushNamedAndRemoveUntil(
                                    Routes.verifyOTPScreen,
                                    arguments: VerifyOTPArgument(
                                      contact: emailController.text.trim(),
                                      data: response.data,
                                      isPassRecover: false,
                                    ),
                                    (route) => false);
                              });
                            } else {
                              return nav.pushNamedAndRemoveUntil(
                                  Routes.dashboard, (route) => false);
                            }
                          }
                        } else {
                          _scrollAnimation();
                        }
                      },
                    ),
                  ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).allReadyHaveAccount,
                  style: textStyle.bodyTextSmall,
                ),
                InkWell(
                  onTap: () {
                    context.nav.pop();
                  },
                  child: Text(
                    S.of(context).login,
                    style: textStyle.subTitle.copyWith(
                      fontSize: 16.sp,
                      color: colors(context).primaryColor,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<void> _scrollAnimation() async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      ),
    );
  }

  Future<bool> performSignUp(
      WidgetRef ref, SignUpCredential signUpCredential) async {
    return await ref
        .watch(authStateNotifierProvider.notifier)
        .signUp(signUpCredential);
  }
}
