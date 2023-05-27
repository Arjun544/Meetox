import 'package:frontend/controllers/map_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/screens/map_screen/components/circle_details_sheet.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

class CustomCircleMarker extends HookWidget {
  const CustomCircleMarker({
    required this.circle,
    required this.tappedCircle,
    super.key,
  });
  final circle_model.Circle circle;
  final Rx<circle_model.Circle> tappedCircle;

  @override
  Widget build(BuildContext context) {
    final MapScreenController controller = Get.find();

    return AnimatedScale(
      scale: tappedCircle.value.id != null ? 1.7 : 1,
      duration: const Duration(milliseconds: 400),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              tappedCircle.value = circle;
              controller.isFiltersVisible.value = false;
              showCustomSheet(
                context: context,
                hasBlur: false,
                child: CircleDetailsSheet(
                  circle,
                  tappedCircle,
                ),
              );
            },
            child: Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: AppColors.customGrey,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 3,
                  color: Colors.lightBlue,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    circle.image!.image!.isEmpty
                        ? profilePlaceHolder
                        : circle.image!.image!,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            child: Icon(
              FlutterRemix.arrow_down_s_fill,
              size: 25.sp,
              color: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
  }
}
