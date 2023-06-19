import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:frontend/core/themes/colors.dart';
import 'package:get/get.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    required this.isPasswordVisible,
    required this.hasFocus,
    required this.prefixIcon,
    super.key,
    this.isPassword = false,
    this.isNumber = false,
    this.autoFocus = true,
    this.formats,
    this.validator,
    this.onChanged,
  });
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData prefixIcon;
  final bool isPassword;
  final bool isNumber;
  final bool autoFocus;
  final TextInputType keyboardType;
  final RxBool hasFocus;
  final RxBool isPasswordVisible;
  final List<TextInputFormatter>? formats;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final inputText = ''.obs;
    return Obx(
      () => TextFormField(
        inputFormatters: formats,
        controller: controller,
        focusNode: focusNode,
        obscureText: !isPasswordVisible.value,
        keyboardType: isNumber
            ? TextInputType.number
            : isPassword
                ? TextInputType.visiblePassword
                : keyboardType,
        style: context.theme.textTheme.labelMedium,
        cursorColor: AppColors.primaryYellow,
        cursorWidth: 3,
        textAlignVertical: TextAlignVertical.bottom,
        autofocus: autoFocus,
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
          suffixIconConstraints: const BoxConstraints(
            minHeight: 40,
            minWidth: 20,
          ),
          prefixIcon: IconTheme(
            data: context.theme.iconTheme.copyWith(color: Colors.grey),
            child: Icon(prefixIcon),
          ),
          suffixIcon: IconTheme(
            data: context.theme.iconTheme.copyWith(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: isPassword
                  ? InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () =>
                          isPasswordVisible.value = !isPasswordVisible.value,
                      child: isPasswordVisible.value
                          ? const Icon(
                              FlutterRemix.eye_fill,
                            )
                          : const Icon(FlutterRemix.eye_off_fill),
                    )
                  : inputText.value.isNotEmpty && hasFocus.value
                      ? InkWell(
                          onTap: () {
                            controller.clear();
                            inputText.value = '';
                          },
                          child: const Icon(FlutterRemix.close_circle_fill),
                        )
                      : const SizedBox.shrink(),
            ),
          ),
          isDense: context.theme.inputDecorationTheme.isDense,
        ),
        validator: validator,
        onChanged: (value) {
          inputText.value = value;
          if (onChanged != null) {
            onChanged!(value);
          }
        },
      ),
    );
  }
}
