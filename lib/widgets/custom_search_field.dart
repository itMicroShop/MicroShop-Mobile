import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:grocerymart/config/app_color.dart';
import 'package:grocerymart/config/app_input_decor.dart';
import 'package:grocerymart/config/app_text_style.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.hintText,
  });
  final TextEditingController searchController;
  final void Function(String?)? onChanged;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);
    return FormBuilderTextField(
      name: 'search',
      decoration: AppInputDecor.loginPageInputDecor.copyWith(
        prefixIcon: const Icon(Icons.search),
        hintText: hintText,
        hintStyle: textStyle.bodyTextSmall.copyWith(
          color: AppStaticColor.grayColor.withOpacity(0.7),
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
      textInputAction: TextInputAction.next,
      controller: searchController,
      onChanged: onChanged,
    );
  }
}
