import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Stack(
        children: [
          Positioned(
            top: 83.h,
            left: 170.w,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors(context).primaryColor!.withOpacity(0.15),
              ),
              height: 276.h,
              width: 276.w,
            ),
          ),
          Positioned(
            top: -85.h,
            left: -119.w,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors(context).primaryColor!.withOpacity(0.15),
              ),
              height: 276.h,
              width: 276.w,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: SizedBox(
              height: 844.h,
              width: 390.w,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.5, sigmaY: 5.5),
            child: SizedBox(
              height: 844.h,
              width: 390.w,
            ),
          ),
          SizedBox(
            height: 844.h,
            width: 390.w,
            child: child,
          ),
        ],
      ),
    );
  }
}
