import 'dart:io';

import 'package:frontend/controllers/add_circle_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/sheets/avatars_sheet.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

class CircleAvatarDetails extends GetView<AddCircleController> {
  const CircleAvatarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.sp),
          SlideInLeft(
            delay: const Duration(milliseconds: 500),
            from: 300,
            child: Text(
              'Avatar for your circle',
              style: context.theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 80.sp),
          Center(
            child: Obx(
              () => CircleAvatar(
                maxRadius: 85.sp,
                backgroundColor: AppColors.primaryYellow,
                backgroundImage: (controller
                            .selectedImage.value.files.isEmpty &&
                        controller.capturedImage.value.path.isEmpty
                    ? AssetImage(
                        controller.globalController
                            .circleAvatars[controller.selectedAvatar.value],
                      )
                    : controller.selectedImage.value.files.isEmpty
                        ? Image.file(
                            File(controller.capturedImage.value.path),
                          ).image
                        : Image.file(
                            File(controller.selectedImage.value.files[0].path!),
                          ).image),
              ),
            ),
          ),
          SizedBox(height: 30.sp),
          Column(
            children: [
              CustomButton(
                width: Get.width * 0.9,
                text: 'Choose from our avatars',
                hasIcon: true,
                color: context.theme.indicatorColor,
                icon: IconTheme(
                  data: context.theme.iconTheme,
                  child: const Icon(
                    FlutterRemix.user_4_fill,
                  ),
                ),
                onPressed: () {
                  showCustomSheet(
                    context: context,
                    child: AvatarsSheet(
                      selectedAvatar: controller.selectedAvatar,
                      avatars: controller.globalController.circleAvatars,
                    ),
                  );
                  controller.capturedImage.value = XFile('');
                  controller.selectedImage.value = const FilePickerResult([]);
                },
              ),
              SizedBox(height: 20.sp),
              CustomButton(
                width: Get.width * 0.9,
                text: 'Capture with camera',
                hasIcon: true,
                color: context.theme.indicatorColor,
                icon: IconTheme(
                  data: context.theme.iconTheme,
                  child: const Icon(
                    FlutterRemix.camera_3_fill,
                  ),
                ),
                onPressed: () async {
                  controller.capturedImage.value =
                      (await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                  ))!;
                  controller.selectedImage.value = const FilePickerResult([]);
                },
              ),
              SizedBox(height: 20.sp),
              CustomButton(
                width: Get.width * 0.9,
                text: 'Choose from gallery',
                hasIcon: true,
                color: context.theme.indicatorColor,
                icon: IconTheme(
                  data: context.theme.iconTheme,
                  child: const Icon(
                    FlutterRemix.image_2_fill,
                  ),
                ),
                onPressed: () async {
                  controller.selectedImage.value =
                      (await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    withData: true,
                  ))!;
                  controller.capturedImage.value = XFile('');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
