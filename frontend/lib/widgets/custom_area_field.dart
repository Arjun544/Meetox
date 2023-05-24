import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/core/themes/colors.dart';
import 'package:get/get.dart';

class CustomAreaField extends StatelessWidget {
  const CustomAreaField({
    required this.hintText,
    required this.text,
    required this.controller,
    required this.focusNode,
    required this.hasFocus,
    super.key,
    this.formats,
    this.validator,
  });
  final String hintText;
  final RxString text;
  final TextEditingController controller;
  final FocusNode focusNode;
  final RxBool hasFocus;
  final List<TextInputFormatter>? formats;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formats,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      style: context.theme.textTheme.labelMedium,
      cursorColor: AppColors.primaryYellow,
      cursorWidth: 3,
      minLines: 6,
      maxLines: 10,
      decoration: InputDecoration(
        filled: context.theme.inputDecorationTheme.filled,
        fillColor: context.theme.inputDecorationTheme.fillColor,
        hintText: hintText,
        hintStyle: context.theme.inputDecorationTheme.hintStyle,
        errorStyle: context.theme.inputDecorationTheme.errorStyle,
        border: context.theme.inputDecorationTheme.border,
        focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
        enabledBorder: context.theme.inputDecorationTheme.enabledBorder,
        focusedErrorBorder:
            context.theme.inputDecorationTheme.focusedErrorBorder,
        isDense: context.theme.inputDecorationTheme.isDense,
      ),
      validator: validator,
      onChanged: (value) {
        text.value = value;
      },
    );
  }
}
