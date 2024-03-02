import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/dashboard/views/widget/onboarding_top_round_custom_path.dart';
import 'package:grocerymart/features/home/view/widget/home_page_hero_slider.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/util/entensions.dart';
import 'package:grocerymart/widgets/buttons/full_width_button.dart';
import 'package:grocerymart/widgets/buttons/outlined_button.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  final contentController = PageController();
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return ScreenWrapper(
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.2.sp,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                  children: images
                      .map(
                        (e) => Container(
                          width: double.infinity,
                          color: Colors.amber,
                          child: Image.asset(
                            e,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: ClipPath(
              clipper: OnBoardingRoundedTopShape(),
              child: Container(
                height: 377.h,
                width: 390.w,
                padding: EdgeInsets.only(
                    top: 65.h, left: 32.w, right: 32.w, bottom: 24.h),
                decoration: const BoxDecoration(
                  color: AppStaticColor.whiteColor,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 190.h,
                      width: double.infinity,
                      child: PageView(
                        controller: contentController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: onboardingContents
                            .map(
                              (e) => Column(
                                children: [
                                  Text(
                                    e['title'],
                                    style: textStyle.title,
                                    textAlign: TextAlign.center,
                                  ),
                                  16.ph,
                                  Text(
                                    e['description'],
                                    style: textStyle.bodyText.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 330.h,
            child: SizedBox(
              width: 390.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images
                    .asMap()
                    .entries
                    .map(
                      (mapentry) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: AnimatedSliderDot(
                          isActive: mapentry.key == selectedIndex,
                          width: 20.w,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: selectedIndex == images.length - 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Consumer(builder: (context, ref, child) {
                        return AppTextButton(
                          width: 170.w,
                          height: 50.h,
                          buttonColor: colors(context).primaryColor,
                          title: 'Get Started',
                          onTap: () {
                            ref
                                .read(hiveStorageProvider)
                                .setFirstOpenValue(value: true);
                            context.nav.pushNamedAndRemoveUntil(
                                Routes.login, (route) => false);
                          },
                        );
                      }),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 170.w,
                          height: 50.h,
                          child: AppOutlinedButton(
                            title: 'Skip',
                            onTap: () {
                              controller.animateToPage(
                                images.length - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                              contentController.animateToPage(
                                onboardingContents.length - 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            borderColor:
                                AppStaticColor.grayColor.withOpacity(0.2),
                            borderRadius: 50.r,
                            buttonColor: AppStaticColor.whiteColor,
                            titleColor: AppStaticColor.grayColor,
                          ),
                        ),
                        AppTextButton(
                          width: 170.w,
                          height: 50.h,
                          buttonColor: colors(context).primaryColor,
                          title: 'Next',
                          onTap: () {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                            contentController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        )
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> images = [
    Assets.images.onboardingImage1.path,
    Assets.images.onboardingImage2.path,
    Assets.images.onboardingImage3.path,
  ];

  final List<Map<String, dynamic>> onboardingContents = [
    {
      "title": "Effortless Shopping",
      'description':
          "Discover the Convenience of Grocery Shopping at Your Fingertips"
    },
    {
      "title": "Maximize Savings",
      'description':
          "Unlock Discounts, Deals, and Fresh Produce Right from Home"
    },
    {
      "title": "Shop Anytime, Anywhere",
      'description':
          "A World of Freshness and Convenience in the Palm of Your Hand"
    }
  ];
}
