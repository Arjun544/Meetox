import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/models/circle_model.dart' as circle_model;
import 'package:frontend/services/circle_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CirclesController extends GetxController {
  final circlesPagingController =
      PagingController<int, circle_model.Circle>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    circlesPagingController.addPageRequestListener((page) async {
      await fetchCircles(page);
    });
  }

  Future<void> fetchCircles(int pageKey) async {
    try {
      final newPage = await CircleServices.userCircles(
        page: pageKey,
      );

      final newItems = newPage.circles;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        circlesPagingController.appendLastPage(newItems!);
      } else if (circlesPagingController.nextPageKey != newPage.nextPage) {
        circlesPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      circlesPagingController.error = e;
    }
  }

  void onDeleteCompleted(
      Map<String, dynamic>? resultData, BuildContext context) {
    if (resultData != null) {
      final circle_model.Circle newCircle = circle_model.Circle.fromJson(
          resultData['deleteCircle'] as Map<String, dynamic>);

      circlesPagingController.itemList!.remove(newCircle);
      circlesPagingController.refresh();
      Navigator.pop(context);
    }
  }
}
