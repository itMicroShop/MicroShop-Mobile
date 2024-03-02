import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocerymart/config/app_input_decor.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/config/hive_contants.dart';
import 'package:grocerymart/config/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocaLizationSelector extends StatelessWidget {
  LocaLizationSelector({super.key});
  final List<AppLanguage> languages = [
    AppLanguage(name: '\ud83c\uddfa\ud83c\uddf8 ENG', value: 'en'),
    // AppLanguage(name: '🇧🇩 বাংলা', value: 'bn'),
    AppLanguage(name: '\ud83c\uddf8\ud83c\udde9 عربي ', value: 'ar')
  ];

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return FormBuilderDropdown<String>(
      decoration: AppInputDecor.loginPageInputDecor.copyWith(
        fillColor: colors(context).accentColor,
      ),
      iconSize: 25.sp,
      initialValue:
          Hive.box(AppHSC.appSettingsBox).get(AppHSC.appLocal) as String?,
      iconEnabledColor: colors(context).primaryColor,
      dropdownColor: colors(context).accentColor,
      name: 'language',
      items: languages
          .map(
            (e) => DropdownMenuItem(
              value: e.value,
              child: Text(
                e.name,
                style: textStyle.subTitle.copyWith(
                    color: colors(context).primaryColor, fontSize: 16),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null && value != '') {
          Hive.box(AppHSC.appSettingsBox).put(AppHSC.appLocal, value);
        }
      },
    );
  }
}

class AppLanguage {
  String name;
  String value;
  AppLanguage({
    required this.name,
    required this.value,
  });
}
