import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/routes.dart';
import 'package:grocerymart/util/context_less_nav.dart';
import 'package:grocerymart/util/global_function.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void addApiInterceptors(Dio dio) {
  dio.options.connectTimeout = const Duration(seconds: 20);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  dio.options.headers['Accept'] = 'application/json';
  // logger
  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 90,
  ));

  // respone handler
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (response, handler) {
        final message = response.data['message'];
        switch (response.statusCode) {
          case 401:
            Box authBox = Hive.box(AppHSC.authBox);
            authBox.delete(AppHSC.authToken);
            ContextLess.nav
                .pushNamedAndRemoveUntil(Routes.login, (route) => false);
            // EasyLoading.showError(message);
            break;
          case 302:
          case 400:
          case 403:
          case 404:
          case 409:
          case 422:
          case 500:
            EasyLoading.showError(message);
            break;
          default:
            break;
        }
        handler.next(response);
      },
      onError: (error, handler) {
        switch (error.type) {
          case DioExceptionType.connectionError:
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.badResponse:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
          case DioExceptionType.unknown:
            EasyLoading.showError('An unknown error occurred');
            break;
          default:
            break;
        }
        if (error.response != null) {
          final message = error.response!.data['message'];
          final statusCode = error.response!.statusCode;
          switch (statusCode) {
            case 401:
              Box authBox = Hive.box(AppHSC.authBox);
              authBox.delete(AppHSC.authToken);
              ApGlobalFunctions.navigatorKey.currentState
                  ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
              break;
            case 403:
              EasyLoading.showError(message);
              break;
            default:
              EasyLoading.showError('unexpected error');
              break;
          }
        }
        handler.reject(error);
      },
    ),
  );
}
