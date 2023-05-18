

import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/helpers/decode_token.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/add_profile_screen/add_profile_screen.dart';
import 'package:frontend/screens/auth_screens/screens_imports.dart';
import 'package:frontend/screens/root_screen.dart';
import 'package:frontend/services/secure_storage_service.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [],
    );
    super.onReady();
  }

  Future<void> onCompleted(User user) async {
    final savedToken =
        await SecureStorageServices.readValue(key: 'accessToken');
    if (savedToken != null) {
      final token = decodeToken(savedToken);

      await Future.delayed(const Duration(seconds: 4));
      if (token['hasExpired'] == true) {
        await Get.offAll(() => const AuthScreen());
      } else if (user.name!.isEmpty) {
        Get.put(UserController(), permanent: true);
        await Get.offAll(() => const AddProfileScreen());
      } else {
        Get.put(UserController(), permanent: true);
        await Get.offAll(() => const DrawerScreen());
      }
    } else {
      await Future.delayed(const Duration(seconds: 4));
      await Get.offAll(() => const AuthScreen());
    }
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }
}
