import 'package:frontend/controllers/add_circle_controller.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_area_field.dart';
import 'package:frontend/widgets/custom_field.dart';
import 'package:frontend/widgets/mini_map.dart';

class CircleDetails extends GetView<AddCircleController> {
  const CircleDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final rootController = Get.find<RootController>();

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.sp,
        ),
        child: Column(
          children: [
            SizedBox(height: 30.sp),
            SlideInLeft(
              delay: const Duration(milliseconds: 500),
              from: 300,
              child: Text(
                'Create a circle to gather the nearby people',
                style: context.theme.textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 30.sp),
            Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomField(
                    hintText: 'Name',
                    autoFocus: false,
                    controller: controller.nameController,
                    focusNode: controller.nameFocusNode,
                    isPasswordVisible: true.obs,
                    hasFocus: controller.hasNameFocus,
                    formats: [
                      LengthLimitingTextInputFormatter(30),
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-z A-Z á-ú Á-Ú 0-9 @.]'),
                      ),
                    ],
                    prefixIcon: FlutterRemix.record_circle_fill,
                    keyboardType: TextInputType.name,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Name is required';
                      }
                      if (val.length < 2) {
                        return 'Enter at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15.sp),
                  CustomAreaField(
                    hintText: 'Description',
                    text: ''.obs,
                    controller: controller.descController,
                    focusNode: controller.descFocusNode,
                    hasFocus: controller.hasDescFocus,
                    formats: [
                      LengthLimitingTextInputFormatter(1000),
                      FilteringTextInputFormatter.allow(
                        RegExp('[a-z A-Z á-ú Á-Ú 0-9 @. \n]'),
                      ),
                    ],
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Description is required';
                      }
                      if (val.length < 2) {
                        return 'Enter at least 2 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 25.sp),
                  Text(
                    'Location',
                    style: context.theme.textTheme.labelSmall,
                  ),
                  SizedBox(height: 15.sp),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: 150.sp,
                      width: Get.width,
                      child: MiniMap(
                        latitude: rootController.currentPosition.value.latitude,
                        longitude:
                            rootController.currentPosition.value.longitude,
                      ),
                    ),
                  ),
                  SizedBox(height: 80.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
