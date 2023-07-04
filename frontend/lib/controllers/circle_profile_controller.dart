import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/follow_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CircleProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  final followersPagingController =
      PagingController<int, User>(firstPageKey: 1);
  final followingPagingController =
      PagingController<int, User>(firstPageKey: 1);

  final RxString followersSearchQuery = ''.obs;
  final RxString followingSearchQuery = ''.obs;
  late Worker followersSearchDebounce;
  late Worker followingSearchDebounce;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
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

  @override
  void onClose() {
    followersPagingController.dispose();
    followersSearchDebounce.dispose();
    followingPagingController.dispose();
    followingSearchDebounce.dispose();
    tabController.dispose();
    super.onClose();
  }
}
