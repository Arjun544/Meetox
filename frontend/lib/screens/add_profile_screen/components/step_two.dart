import 'dart:io';

import 'package:frontend/controllers/add_profile_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/instances.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/sheets/avatars_sheet.dart';
import 'package:frontend/widgets/show_custom_sheet.dart';

class StepTwo extends GetView<AddProfileController> {
  const StepTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: globalHorizentalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 75.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SlideInLeft(
                child: Text(
                  'Your Avatar',
                  style: context.theme.textTheme.titleLarge,
                ),
              ),
              SmoothPageIndicator(
                controller: controller.pageController, // PageController
                count: 3,
                effect: ExpandingDotsEffect(
                  dotHeight: 6.sp,
                  dotWidth: 6.sp,
                  activeDotColor: AppColors.primaryYellow,
                  dotColor: AppColors.customGrey,
                ), // your preferred effect
                onDotClicked: (index) {},
              ),
            ],
          ),
          SizedBox(height: 15.sp),
          SlideInLeft(
            delay: const Duration(milliseconds: 500),
            from: 300,
            child: Text(
              'Choose your avatar to look diffferent and awesome',
              style: context.theme.textTheme.labelSmall,
            ),
          ),
          Obx(
            () => SizedBox(
              height: (controller.currentLoginProvider.value == 'Facebook' ||
                          controller.currentLoginProvider.value == 'Google') &&
                      controller.socialProfile.value.isEmpty
                  ? 30.sp
                  : 50.sp,
            ),
          ),
          Center(
            child: Obx(
              () => CircleAvatar(
                maxRadius: 60.sp,
                backgroundColor: AppColors.primaryYellow,
                // If login provider is Facebook or Google, then show the profile image of Facebook or Google. otherwise, show the selected avatar or image.
                backgroundImage: (controller.currentLoginProvider.value ==
                                'Facebook' ||
                            controller.currentLoginProvider.value ==
                                'Google') &&
                        controller.socialProfile.value.isNotEmpty
                    ? CachedNetworkImageProvider(controller.socialProfile.value)
                    : controller.selectedImage.value.files.isEmpty &&
                            controller.capturedImage.value.path.isEmpty
                        ? AssetImage(
                            controller.globalController
                                .userAvatars[controller.selectedAvatar.value],
                          )
                        : controller.selectedImage.value.files.isEmpty
                            ? Image.file(
                                File(controller.capturedImage.value.path),
                              ).image
                            : Image.file(
                                File(
                                  controller.selectedImage.value.files[0].path!,
                                ),
                              ).image,
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              height: (controller.currentLoginProvider.value == 'Facebook' ||
                          controller.currentLoginProvider.value == 'Google') &&
                      controller.socialProfile.value.isEmpty
                  ? 30.sp
                  : 50.sp,
            ),
          ),
          Column(
            children: [
              Obx(
                () => controller.isSocialProfileLoading.value
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.primaryYellow,
                        size: 35.sp,
                      )
                    : (controller.currentLoginProvider.value == 'Facebook' ||
                                controller.currentLoginProvider.value ==
                                    'Google') &&
                            controller.socialProfile.value.isEmpty
                        ? CustomButton(
                            width: Get.width * 0.9,
                            text: 'Set social profile',
                            hasIcon: true,
                            color:
                                context.theme.bottomSheetTheme.backgroundColor!,
                            icon: IconTheme(
                              data: context.theme.iconTheme,
                              child: const Icon(
                                FlutterRemix.user_4_fill,
                              ),
                            ),
                            onPressed: () async {
                              controller.isSocialProfileLoading.value = true;
                              controller.capturedImage.value = XFile('');
                              controller.selectedImage.value =
                                  const FilePickerResult([]);
                              if (controller.currentLoginProvider.value ==
                                  'Facebook') {
                                final fbUser = await facebookAuth.getUserData();

                                controller.socialProfile.value =
                                    fbUser['picture']['data']['url'] as String;
                              } else if (controller
                                      .currentLoginProvider.value ==
                                  'Google') {
                                await googleSignIn.signInSilently();

                                controller.socialProfile.value =
                                    googleSignIn.currentUser!.photoUrl!;
                              }
                              controller.isSocialProfileLoading.value = false;
                            },
                          )
                        : const SizedBox.shrink(),
              ),
              SizedBox(height: 20.sp),
              CustomButton(
                width: Get.width * 0.9,
                text: 'Choose from our avatars',
                hasIcon: true,
                color: context.theme.bottomSheetTheme.backgroundColor!,
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
                      avatars: controller.globalController.userAvatars,
                    ),
                  );

                  controller.capturedImage.value = XFile('');
                  controller.selectedImage.value = const FilePickerResult([]);
                  controller.socialProfile.value = '';
                },
              ),
              SizedBox(height: 20.sp),
              CustomButton(
                width: Get.width * 0.9,
                text: 'Capture with camera',
                hasIcon: true,
                color: context.theme.bottomSheetTheme.backgroundColor!,
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
                  controller.socialProfile.value = '';
                },
              ),
              SizedBox(height: 20.sp),
              CustomButton(
                width: Get.width * 0.9,
                text: 'Choose from gallery',
                hasIcon: true,
                color: context.theme.bottomSheetTheme.backgroundColor!,
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
                  controller.socialProfile.value = '';
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
