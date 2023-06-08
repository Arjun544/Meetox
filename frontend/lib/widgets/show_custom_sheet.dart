import 'dart:ui';

import 'package:frontend/core/imports/core_imports.dart';

Future<void> Function({
  required BuildContext context,
  required Widget child,
  bool hasBlur,
  bool enableDrag,
}) showCustomSheet = ({
  required BuildContext context,
  required Widget child,
  bool hasBlur = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    elevation: 0,
    useSafeArea: true,
    enableDrag: enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Get.back,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: hasBlur ? 4 : 0,
          sigmaY: hasBlur ? 4 : 0,
        ),
        child: SizedBox(
          child: child,
        ),
      ),
    ),
  );
};
