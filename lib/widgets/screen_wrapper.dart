import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/util/global_function.dart';

class ScreenWrapper extends StatelessWidget {
  const ScreenWrapper({
    Key? key,
    required this.child,
    this.padding,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget child;
  final Widget? bottomNavigationBar;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    ApGlobalFunctions.changeStatusBarColor(color: Colors.transparent);
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        height: 844.h,
        width: 390.w,
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
