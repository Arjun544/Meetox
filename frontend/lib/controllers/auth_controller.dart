import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/services/common_services.dart';

class AuthController {
  final isLoading = false.obs;

  Future<void> handleLoginWithGmail(dynamic runMutation, dynamic result) async {
    final user = await AuthServices.loginWithGmail(
      isLoading: isLoading,
    );
    currentUser.value.name = user.displayName;
    currentUser.value.displayPic!.profile = user.photoUrl;
    // ignore: invalid_use_of_protected_member
    currentUser.refresh();
    final address = await CommonServices.getAddress();
    isLoading.value = result.isLoading as bool;

    runMutation({
      'email': user.email,
      'address': address,
    });
  }
}
