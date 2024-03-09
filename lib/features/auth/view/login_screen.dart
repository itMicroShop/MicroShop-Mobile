import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/auth/logic/auth_provider.dart';
import 'package:grocerymart/features/auth/model/login_credentials.dart';
import 'package:grocerymart/features/auth/view/widget/auth_wrapper.dart';
import 'package:grocerymart/features/auth/view/widget/build_textfield.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/busy_loader.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController numOrEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final List<FocusNode> fNodes = [FocusNode(), FocusNode()];
  final GlobalKey<FormBuilderState> _formkey = GlobalKey<FormBuilderState>();
  final ScrollController _scrollController = ScrollController();
  bool showPass = false;
  @override
  void initState() {
    numOrEmailController.text = '';
    passwordController.text = '';
    super.initState();
  }

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
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: SizedBox(
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.svg.appLogo,
                      width: 160.w,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    bottom: 20.h,
                    left: 24.w,
                    right: 24.w,
                    top: 0,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          numOrEmailController.text = '';
                          passwordController.text = '';
                        });
                      },
                      child: Text(
                        S.of(context).login,
                        style: textStyle.title,
                      ),
                    ),
                    16.ph,
                    Text(
                      S.of(context).loginDes,
                      style: textStyle.bodyText.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    48.ph,
                    CustomTextFormField(
                      name: 'Email or Phone Number',
                      focusNode: fNodes[0],
                      hintText: S.of(context).emialOrPhone,
                      textInputType: TextInputType.text,
                      controller: numOrEmailController,
                    ),
                    14.ph,
                    CustomTextFormField(
                      name: 'Password',
                      focusNode: fNodes[1],
                      obscureText: !showPass,
                      hintText: S.of(context).yourPassword,
                      textInputType: TextInputType.text,
                      controller: passwordController,
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
                    20.ph,
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.passwordRecover);
                          },
                          child: Text(
                            S.of(context).forgetPassword,
                            style: textStyle.bodyTextSmall.copyWith(
                              color: colors(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    32.ph,
                    isLoading
                        ? const SizedBox(
                            height: 100,
                            width: 100,
                            child: BusyLoader(),
                          )
                        : SizedBox(
                            height: 50.h,
                            child: AppTextButton(
                              title: S.of(context).login,
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  LoginCredentials credentials =
                                      LoginCredentials(
                                    numOrEmailController.text,
                                    passwordController.text,
                                  );

                                  final nav = context.nav;
                                  final bool isSuccess =
                                      await performLogin(ref, credentials);
                                  if (isSuccess) {
                                    EasyLoading.showSuccess(
                                        'Signed in successfully');
                                    return nav.pushNamedAndRemoveUntil(
                                        Routes.dashboard, (route) => false);
                                  }
                                } else {
                                  _scrollAnimation();
                                }
                              },
                            ),
                          ),
                    80.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).dontHaveAccount,
                          style: textStyle.bodyTextSmall,
                        ),
                        InkWell(
                          onTap: () {
                            context.nav.pushNamed(Routes.signUp);
                          },
                          child: Text(
                            S.of(context).signUp,
                            style: textStyle.subTitle.copyWith(
                                fontSize: 16.sp,
                                color: colors(context).primaryColor),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

  Future<bool> performLogin(
      WidgetRef ref, LoginCredentials loginCredentials) async {
    return await ref
        .watch(authStateNotifierProvider.notifier)
        .loginWithEmailAndPassword(loginCredentials);
  }
}
