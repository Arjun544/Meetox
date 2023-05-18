import 'dart:developer';

import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/dialogues/location_permission_dialogue.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> hasLocationPermission() async {
  if (await Permission.location.serviceStatus.isEnabled) {
    final locationPermission = await Permission.location.status;
    if (locationPermission.isGranted) {
      log('Location permission: Granted');

      return true;
    } else {
      var result = PermissionStatus.denied;

      if (locationPermission.isDenied) {
        log('Location permission: Denied');

        await Get.generalDialog(
          barrierDismissible: true,
          barrierLabel: '',
          pageBuilder: (context, animation, secondaryAnimation) =>
              FadeTransition(
            opacity: animation,
            child: LocationPermissionDialogue(
              title: "Let's find best matches?",
              btnText: 'Enable location',
              onPressed: () async => {
                await Permission.location.request(),
                Get.back(),
              },
            ),
          ),
        );
      } else if (locationPermission.isPermanentlyDenied) {
        log('Location permission: Permanently Denied');
        result = await Permission.location.request();

        result == PermissionStatus.granted
            ? const SizedBox.shrink()
            : Get.generalDialog(
                barrierDismissible: true,
                barrierLabel: '',
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: LocationPermissionDialogue(
                    title: "Let's find best matches?",
                    btnText: 'Enable location',
                    onPressed: () async => {
                      await openAppSettings(),
                      Get.back(),
                    },
                  ),
                ),
              );
      }

      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  } else {
    await Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
        opacity: animation,
        child: LocationPermissionDialogue(
          title: "Let's find best matches?",
          btnText: 'Open Settings',
          onPressed: () async => Geolocator.openLocationSettings(),
        ),
      ),
    );
    log('Location permission: No service available');
    return false;
  }
}
