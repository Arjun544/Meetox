// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

export 'package:get/get.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    required this.text,
    required this.onPressed,
    required this.color,
    super.key,
  });
  final String text;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: context.theme.textTheme.labelMedium!.copyWith(
          color: color,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
