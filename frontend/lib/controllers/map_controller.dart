import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/helpers/has_location_permission.dart';

class MapScreenController extends GetxController
    with GetTickerProviderStateMixin {
  final RootController rootController = Get.find();
  MapController? mapController;
  RxString currentMapStyle = 'default'.obs;

  RxBool isLoading = false.obs;
  RxBool hasAppliedFilters = false.obs;
  RxBool isLocationPrecise = false.obs;
  RxString currentMainFilter = 'All'.obs;
  RxBool isCurrentFilterMarkVisible = false.obs;
  RxBool isDraggingMap = false.obs;
  RxBool isFiltersVisible = true.obs;

  // Filters
  final RxInt markersFilter = 0.obs;
  final RxDouble radius = (currentUser.value.isPremium! ? 600.0 : 300.0).obs;
  // final RxList<circle_model.Circle> oldCircles = <circle_model.Circle>[].obs;
  // final RxList<QuestionModel> oldQuestions = <QuestionModel>[].obs;
  // final RxList<UserModel> oldUsers = <UserModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await hasLocationPermission();
    isLocationPrecise.value = getStorage.read('isPrecise') ?? false;
    currentMapStyle.value = getStorage.read('currentMapStyle') ?? 'default';
   
  }

  void animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween<double>(
      begin: mapController!.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: mapController!.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(begin: mapController!.zoom, end: destZoom);

    final controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController!.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
