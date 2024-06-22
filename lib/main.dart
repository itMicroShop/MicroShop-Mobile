import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:grocerymart/config/app_constants.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:grocerymart/features/cart/model/hive_cart_model.dart';
import 'package:grocerymart/firebase_options.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/service/hive_logic.dart';
import 'package:grocerymart/util/global_function.dart';
import 'package:grocerymart/utils/notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  firebaseMessagingForgroundHandler();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint(fcmToken);
  Stripe.publishableKey = AppConstant.publishableKey;
  await Hive.initFlutter();
  await Hive.openBox(AppHSC.authBox);
  await Hive.openBox(AppHSC.userBox);
  await Hive.openBox(AppHSC.deliveryAddressBox);
  await Hive.openBox(AppHSC.appSettingsBox);
  Hive.registerAdapter(HiveCartModelAdapter());
  await Hive.openBox<HiveCartModel>(AppHSC.cartBox);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Locale resolveLocal({required String langCode}) {
    return Locale(langCode);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isDarkTheme = false;
    return ScreenUtilInit(
      designSize: const Size(390, 844), // XD Design Sizes
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: Hive.box(AppHSC.appSettingsBox).listenable(),
          builder: (context, appSettingsBox, _) {
            final isDark = appSettingsBox.get(AppHSC.isDarkTheme) as bool?;
            final selectedLocal =
                appSettingsBox.get(AppHSC.appLocal) as String?;
            if (selectedLocal == null) {
              appSettingsBox.put(AppHSC.appLocal, 'en');
            }
            if (isDark == null) {
              ref.read(hiveStorageProvider).isDarkTheme(value: isDarkTheme);
            }
            return ConnectivityAppWrapper(
              app: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: ApGlobalFunctions.navigatorKey,
                scaffoldMessengerKey: ApGlobalFunctions.getSnackbarKey(),
                title: 'MicoShop',
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  FormBuilderLocalizations.delegate,
                ],
                locale: resolveLocal(langCode: selectedLocal ?? 'en'),
                localeResolutionCallback: (deviceLocal, supportedLocales) {
                  if (selectedLocal == '') {
                    appSettingsBox.put(
                      AppHSC.appLocal,
                      deviceLocal?.languageCode,
                    );
                  }
                  for (final locale in supportedLocales) {
                    if (locale.languageCode == deviceLocal!.languageCode) {
                      return deviceLocal;
                    }
                  }
                  return supportedLocales.first;
                },
                supportedLocales: S.delegate.supportedLocales,
                theme: getAppTheme(
                  context: context,
                  isDarkTheme: isDark ?? isDarkTheme,
                ),
                onGenerateRoute: generatedRoutes,
                initialRoute: Routes.splash,
                builder: EasyLoading.init(),
              ),
            );
          },
        );
      },
    );
  }
}
// USH