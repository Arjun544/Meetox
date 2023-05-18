import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/screens/auth_screens/auth_screen.dart';
import 'package:frontend/services/secure_storage_service.dart';

class AuthServices {
  static Future<GoogleSignInAccount> loginWithGmail({
    required RxBool isLoading,
  }) async {
    try {
      isLoading.value = true;

      final googleSignInAccount = await googleSignIn.signIn();

      logSuccess('Google user: $googleSignInAccount');
      isLoading.value = false;
      return googleSignInAccount!;
    } catch (e) {
      isLoading.value = false;
      logError(e.toString());
      showToast("Can't login with Google, try again");
    }
    return throw Exception('Failed to login with Google');
  }

  static Future<void> logout() async {
    try {
      await googleSignIn.signOut();
      await SecureStorageServices.deleleValue(key: 'accessToken');
      await Get.offAll(() => const AuthScreen());
    } catch (e) {
      logError(e.toString());
      showToast("Can't logout, try again");
    }
  }
}
