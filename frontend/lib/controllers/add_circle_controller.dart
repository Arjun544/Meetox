import 'dart:developer';

import 'package:frontend/controllers/global_controller.dart';
import 'package:frontend/controllers/root_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/helpers/convert_base64_image.dart';
import 'package:frontend/helpers/get_asset_image.dart';
import 'package:frontend/models/user_model.dart';

class AddCircleController extends GetxController {
  final GlobalController globalController = Get.find();
  // final ConversationController conversationController = Get.find();
  // final PagingController<int, UserModel> followersPagingController =
  //     PagingController(firstPageKey: 1);

  final RootController rootController = Get.find();
  final PageController pageController = PageController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descFocusNode = FocusNode();

  final RxBool hasNameFocus = false.obs;
  final RxBool hasDescFocus = false.obs;

  final RxInt currentStep = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isPrivate = false.obs;
  final RxDouble limit = 50.0.obs;
  final RxInt selectedAvatar = 0.obs;
  Rx<XFile> capturedImage = XFile('').obs;
  Rx<FilePickerResult> selectedImage = const FilePickerResult([]).obs;
  final RxList<User> selectedMembers = <User>[].obs;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameFocusNode.addListener(() {
        hasNameFocus.value = nameFocusNode.hasFocus;
      });
      descFocusNode.addListener(() {
        hasDescFocus.value = descFocusNode.hasFocus;
      });
    });

    super.onInit();
  }

  Future<void> handleAddCircle(
    BuildContext context,
    dynamic runMutation,
  ) async {
    String? base64Profile;
    if (capturedImage.value.path.isEmpty &&
        selectedImage.value.files.isNotEmpty) {
      base64Profile =
          convertIntoBase64Image(selectedImage.value.files[0].path!);
    }

    if (selectedImage.value.files.isEmpty &&
        capturedImage.value.path.isNotEmpty) {
      base64Profile = convertIntoBase64Image(capturedImage.value.path);
    }
    if (selectedImage.value.files.isEmpty && capturedImage.value.path.isEmpty) {
      final imageFromAsset = await getImageFileFromAssets(
        globalController.circleAvatars[selectedAvatar.value],
      );
      log(imageFromAsset.path);

      base64Profile = convertIntoBase64Image(imageFromAsset.path);
    }

    // Takes selected members and maps each element to its id, then creates a new list with the ids and inserts the current user's id at the beginning of the list.
    final members = selectedMembers
        .map<String>((element) => element.id!)
        .toList()
      ..insert(0, currentUser.value.id!);

    runMutation({
      'name': nameController.text.trim(),
      'description': descController.text.trim(),
      'image': base64Profile,
      'isPrivate': isPrivate.value,
      'limit': double.parse(limit.value.toStringAsFixed(0)),
      'members': members,
      'location': {
        'address': currentUser.value.location!.address,
        'coordinates': [
          currentUser.value.location!.coordinates![0],
          currentUser.value.location!.coordinates![1],
        ],
      }
    });

    // final newCircle = await mutation.mutateAsync(circle);

    // if (mutation.hasError) {
    //   log('mutation error: ${mutation.error}');
    //   showToast('Circle creation failed');
    //   mutation.reset();
    // } else if (mutation.hasData) {
    //   showToast('Circle created successfully');
    //   Get.back();

    //   // Update user circles with the new data
    //   QueryBowl.of(context).setQueryData<CircleModel, void>(
    //       CachingKeys.userCirclesKey, (oldData) {
    //     oldData!.circles!.insert(0, newCircle!);
    //     return oldData;
    //   });

    //   if (rootController.circlesPagingController.itemList != null) {
    //     rootController.circlesPagingController.itemList!.insert(0, newCircle!);
    //   }

    // Set data back to original
  }
}
