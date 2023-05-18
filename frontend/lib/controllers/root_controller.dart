import 'dart:developer';

import 'package:flutter_zoom_drawer/config.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/helpers/has_location_permission.dart';
import 'package:frontend/screens/conversation_screen/conversation_screen.dart';
import 'package:frontend/screens/feed_screen/feed_screen.dart';
import 'package:frontend/screens/map_screen/map_screen.dart';
import 'package:frontend/screens/notification_screen/notification_screen.dart';
import 'package:frontend/services/user_services.dart';

import 'map_controller.dart';

class RootController extends GetxController {
  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  final selectedTab = 1.obs;

  final List<Widget> items = [
    const MapScreen(),
    const FeedScreen(),
    const SizedBox.shrink(),
    const ConversationScreen(),
    const NotificationScreen(),
  ];
  final mapNavigatorKey = GlobalKey<NavigatorState>();
  final feedsNavigatorKey = GlobalKey<NavigatorState>();
  final addNavigatorKey = GlobalKey<NavigatorState>();
  final conversationsNavigatorKey = GlobalKey<NavigatorState>();
  final notificationsNavigatorKey = GlobalKey<NavigatorState>();

  Rx<LatLngBounds> mapBounds = LatLngBounds(LatLng(0, 0), LatLng(0, 0)).obs;
  Rx<LocationPermission> locationPermission = LocationPermission.denied.obs;

  RxString currentAddress = ''.obs;
  Rx<Position> currentPosition = Position(
    latitude: 0,
    accuracy: 0,
    altitude: 0,
    longitude: 0,
    speed: 0,
    heading: 0,
    speedAccuracy: 0,
    timestamp: DateTime.now(),
  ).obs;

  @override
  Future<void> onInit() async {
    await getLocation();
    super.onInit();
  }

  Future<bool> getLocationPermissions() async => hasLocationPermission();

  Future<void> getLocation() async {
    final hasPermission = await getLocationPermissions();

    logSuccess('hasPermission: $hasPermission');
    if (hasPermission) {
      // ignore: omit_local_variable_types
      final bool isPrecise = getStorage.read('isPrecise') ?? false;

      final newPostion = await Geolocator.getCurrentPosition(
        desiredAccuracy:
            isPrecise ? LocationAccuracy.best : LocationAccuracy.lowest,
      );

      // If current location & address are available, update in db
      if (newPostion.toString().isNotEmpty) {
        log('With location');

        currentPosition.value = newPostion;

        final placemarks = await placemarkFromCoordinates(
          currentPosition.value.latitude,
          currentPosition.value.longitude,
        );

        final address =
            '${placemarks[0].administrativeArea}, ${placemarks[0].isoCountryCode}';

        log('Updated Address');
        await UserServices.updateUserLocation(
          address: address,
          coordinates: [
            currentPosition.value.latitude,
            currentPosition.value.longitude
          ],
        );

        mapBounds.value = !currentUser.value.isPremium!
            // Approx 300 kms
            ? LatLngBounds(
                LatLng(
                  currentPosition.value.latitude - 1.1,
                  currentPosition.value.longitude - 1.1,
                ),
                LatLng(
                  currentPosition.value.latitude + 1.1,
                  currentPosition.value.longitude + 1.1,
                ),
              )
            : LatLngBounds(
                // Approx 600 kms
                LatLng(
                  currentPosition.value.latitude - 2.1,
                  currentPosition.value.longitude - 2.1,
                ),
                LatLng(
                  currentPosition.value.latitude + 2.1,
                  currentPosition.value.longitude + 2.1,
                ),
              );
      }
    } else {
      log('Without location ${currentUser.value.location}');
      currentPosition.value = Position(
        latitude: currentUser.value.location!.coordinates![0],
        longitude: currentUser.value.location!.coordinates![1],
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
      );
      mapBounds.value = !currentUser.value.isPremium!
          // Approx 300 kms
          ? LatLngBounds(
              LatLng(
                currentPosition.value.latitude - 1.1,
                currentPosition.value.longitude - 1.1,
              ),
              LatLng(
                currentPosition.value.latitude + 1.1,
                currentPosition.value.longitude + 1.1,
              ),
            )
          : LatLngBounds(
              // Approx 600 kms
              LatLng(
                currentPosition.value.latitude - 2.1,
                currentPosition.value.longitude - 2.1,
              ),
              LatLng(
                currentPosition.value.latitude + 2.1,
                currentPosition.value.longitude + 2.1,
              ),
            );

      final mapScreenController = Get.put(MapScreenController());
      // ignore: cascade_invocations
      mapScreenController.animatedMapMove(
        LatLng(
          currentUser.value.location!.coordinates![0],
          currentUser.value.location!.coordinates![1],
        ),
        15,
      );
    }
  }
}
