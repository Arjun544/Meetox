import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';

void showToast(String message) => Get.rawSnackbar(
      message: message,
      maxWidth: Get.width * 0.8,
      snackPosition: SnackPosition.top,
      backgroundColor: AppColors.customBlack,
      borderRadius: 14,
      barBlur: 10,
      overlayBlur: 2,
      shouldIconPulse: false,
      icon: const Icon(
        FlutterRemix.information_fill,
        color: Colors.white,
      ),
    );
