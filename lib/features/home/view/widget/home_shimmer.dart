import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colors(context).accentColor ?? AppStaticColor.accentColor,
      highlightColor: AppStaticColor.whiteColor,
      enabled: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 80.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerTop(),
              SizedBox(
                height: 55.h,
              ),
              shimmerBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerTop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20.h,
          width: 200.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppStaticColor.accentColor,
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          height: 14.h,
          width: 260.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppStaticColor.accentColor,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 14.h,
          width: 220.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppStaticColor.accentColor,
          ),
        ),
      ],
    );
  }

  Widget shimmerBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppStaticColor.accentColor,
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          height: 140.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppStaticColor.accentColor,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 260.h,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppStaticColor.accentColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppStaticColor.accentColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppStaticColor.accentColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          height: 140.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppStaticColor.accentColor,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
