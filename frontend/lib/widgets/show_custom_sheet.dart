import 'dart:ui';

import 'package:frontend/core/imports/core_imports.dart';

Future<void> Function({required BuildContext context, required Widget child})
    showCustomSheet = ({required BuildContext context, required Widget child}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    elevation: 0,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Get.back,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: SizedBox(
          child: child,
        ),
      ),
    ),
  );
};
