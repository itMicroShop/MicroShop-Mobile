import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocerymart/gen/assets.gen.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/util/context_less_nav.dart';
import 'package:grocerymart/utils/api_client.dart';
import 'package:grocerymart/widgets/screen_wrapper.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.wait([
      ref.read(hiveStorageProvider).loadTokenAndUser(),
    ]).then((data) {
      if (data.first![0] == true &&
          (data.first![1] == null || data.first![2] == null)) {
        context.nav.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      } else if ((data.first![1] != null) && (data.first![2] != null)) {
        ref.read(apiClientProvider).updateToken(token: data.first![1]);
        context.nav.pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
      } else {
        context.nav
            .pushNamedAndRemoveUntil(Routes.onBoarding, (route) => false);
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      child: Center(
        child: Hero(
          tag: 'icon',
          child: SvgPicture.asset(
            Assets.svg.appLogo,
            width: 166,
          ),
        ),
      ),
    );
  }
}
