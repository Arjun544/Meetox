import 'package:frontend/controllers/circle_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/sheets/avatars_sheet.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

class AvatarSheet extends GetView<CircleProfileController> {
  final Rx<circle_model.Image> image;

  const AvatarSheet(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.35,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
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
              image.value = circle_model.Image(image: null, imageId: '');
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
              controller.capturedImage.value = (await ImagePicker().pickImage(
                source: ImageSource.camera,
                imageQuality: 50,
              ))!;
              controller.selectedImage.value = const FilePickerResult([]);
              image.value = circle_model.Image(image: null, imageId: '');
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
              image.value = circle_model.Image(image: null, imageId: '');
            },
          ),
        ],
      ),
    );
  }
}
