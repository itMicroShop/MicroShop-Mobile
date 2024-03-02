// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:grocerymart/config/app_input_decor.dart';
import 'package:grocerymart/config/app_text_style.dart';
import 'package:grocerymart/generated/l10n.dart';
import 'package:grocerymart/util/entensions.dart';

class CustomTextFormField extends StatelessWidget {
  final String name;
  final FocusNode focusNode;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final double? width;
  final Widget? widget;
  final bool? obscureText;
  const CustomTextFormField(
      {Key? key,
      required this.name,
      required this.focusNode,
      required this.hintText,
      required this.textInputType,
      required this.controller,
      this.width,
      this.widget,
      this.obscureText})
      : super(key: key);

  String errorText({required String fieldName, required BuildContext context}) {
    return '$fieldName ${S.of(context).validationMessage}';
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: textStyle.bodyTextSmall,
        ),
        12.ph,
        SizedBox(
          width: width,
          child: FormBuilderTextField(
            focusNode: focusNode,
            name: name,
            obscureText: obscureText ?? false,
            decoration: AppInputDecor.loginPageInputDecor
                .copyWith(hintText: hintText, suffixIcon: widget),
            keyboardType: textInputType,
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(
                  errorText: errorText(fieldName: hintText, context: context),
                ),
              ],
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}

Widget buildTextField({
  required String name,
  required FocusNode focusNode,
  required String hintText,
  required TextInputType textInputType,
  required TextEditingController controller,
  required double? width,
  required BuildContext context,
}) {
  final textStyle = AppTextStyle(context);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: textStyle.bodyTextSmall,
      ),
      14.ph,
      SizedBox(
        width: width ?? 114,
        child: FormBuilderTextField(
          focusNode: focusNode,
          name: name,
          decoration: AppInputDecor.loginPageInputDecor.copyWith(
            hintText: hintText,
          ),
          keyboardType: textInputType,
          textInputAction: TextInputAction.next,
          validator: FormBuilderValidators.compose(
            [FormBuilderValidators.required()],
          ),
          controller: controller,
        ),
      ),
    ],
  );
}
