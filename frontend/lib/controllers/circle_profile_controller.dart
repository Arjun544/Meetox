import 'package:frontend/controllers/global_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/follow_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'circles_controller.dart';

class CircleProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final GlobalController globalController = Get.find();
  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();
  late TabController tabController;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final followersPagingController =
      PagingController<int, User>(firstPageKey: 1);
  final followingPagingController =
      PagingController<int, User>(firstPageKey: 1);

  final RxBool isPrivate = false.obs;
  final RxString nameText = ''.obs;
  final RxString descText = ''.obs;
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode descFocusNode = FocusNode();
  final RxInt selectedAvatar = 0.obs;
  Rx<XFile> capturedImage = XFile('').obs;
  Rx<FilePickerResult> selectedImage = const FilePickerResult([]).obs;

  final RxBool hasNameFocus = false.obs;
  final RxBool hasDescFocus = false.obs;

  final RxString followersSearchQuery = ''.obs;
  final RxString followingSearchQuery = ''.obs;
  late Worker followersSearchDebounce;
  late Worker followingSearchDebounce;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      nameFocusNode.addListener(() {
        hasNameFocus.value = nameFocusNode.hasFocus;
      });
      descFocusNode.addListener(() {
        hasDescFocus.value = descFocusNode.hasFocus;
      });
    });
    followersPagingController.addPageRequestListener((page) async {
      await fetchFollowers(page);
      followersSearchDebounce = debounce(
        followersSearchQuery,
        (value) {
          followersPagingController.refresh();
        },
        time: const Duration(seconds: 2),
      );
    });
    followingPagingController.addPageRequestListener((page) async {
      await fetchFollowing(page);
      followingSearchDebounce = debounce(
        followingSearchQuery,
        (value) {
          followingPagingController.refresh();
        },
        time: const Duration(seconds: 2),
      );
    });
  }

  Future<void> fetchFollowers(int pageKey) async {
    try {
      final newPage = await FollowServices.userFollowers(
        id: currentUser.value.id!,
        page: pageKey,
        name: followersSearchQuery.value.isEmpty
            ? null
            : followersSearchQuery.value,
      );

      final newItems = newPage.followers;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        followersPagingController.appendLastPage(newItems!);
      } else if (followersPagingController.nextPageKey != newPage.nextPage) {
        followersPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      followersPagingController.error = e;
    }
  }

  Future<void> fetchFollowing(int pageKey) async {
    try {
      final newPage = await FollowServices.userFollowing(
        id: currentUser.value.id!,
        page: pageKey,
        name: followingSearchQuery.value.isEmpty
            ? null
            : followingSearchQuery.value,
      );

      final newItems = newPage.following;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        followingPagingController.appendLastPage(newItems!);
      } else if (followingPagingController.nextPageKey != newPage.nextPage) {
        followingPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      followingPagingController.error = e;
    }
  }

  void onEditComplete(Map<String, dynamic>? resultData,
      ValueNotifier<circle_model.Circle> circle) {
    if (resultData != null && resultData['editCircle'] != null) {
      final bool hasCirclesController = Get.isRegistered<CirclesController>();
      if (hasCirclesController) {
        final circle_model.Circle updatedCircle = circle_model.Circle.fromJson(
            resultData['editCircle'] as Map<String, dynamic>);
        final CirclesController circlesController = Get.find();

        circlesController.circlesPagingController.itemList![circlesController
                .circlesPagingController.itemList!
                .indexWhere((element) => element.id == updatedCircle.id)] =
            updatedCircle;

        circle.value = updatedCircle;

        circlesController.circlesPagingController
            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            .notifyListeners();
      }

      nameController.clear();
      descController.clear();
      isPrivate.value = false;
      Get.back();
    }
  }

  @override
  void onClose() {
    followersPagingController.dispose();
    followersSearchDebounce.dispose();
    followingPagingController.dispose();
    followingSearchDebounce.dispose();
    tabController.dispose();
    nameController.dispose();
    descController.dispose();
    super.onClose();
  }
}
