import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/circle_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MembersController extends GetxController {
  final String id;
  MembersController(this.id);

  final membersPagingController = PagingController<int, User>(firstPageKey: 1);

  final RxString membersSearchQuery = ''.obs;
  late Worker membersSearchDebounce;

  @override
  void onInit() {
    super.onInit();

    membersPagingController.addPageRequestListener((page) async {
      await fetchMembers(page);
      membersSearchDebounce = debounce(
        membersSearchQuery,
        (value) {
          membersPagingController.refresh();
        },
        time: const Duration(seconds: 2),
      );
    });
  }

  Future<void> fetchMembers(int pageKey) async {
    try {
      final newPage = await CircleServices.circleMembers(
        id: id,
        page: pageKey,
        name:
            membersSearchQuery.value.isEmpty ? null : membersSearchQuery.value,
      );

      final newItems = newPage.members;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        membersPagingController.appendLastPage(newItems!);
      } else if (membersPagingController.nextPageKey != newPage.nextPage) {
        membersPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      membersPagingController.error = e;
    }
  }
}
