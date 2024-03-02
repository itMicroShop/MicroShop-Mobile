import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//allows navigation with context.nav
extension ElTanvirNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}

//converts
extension NumModifier on num {
  Duration get miliSec {
    return Duration(milliseconds: int.parse(toString()));
  }


  /// Puts A Vertical Spacer With the value
  SizedBox get ph {
    return SizedBox(
      height: toDouble().h,
    );
  }

  /// Puts A Horizontal Spacer With the value
  SizedBox get pw {
    return SizedBox(
      width: toDouble().w,
    );
  }
}
