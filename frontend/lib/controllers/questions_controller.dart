import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/services/question_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/question_model.dart';

class QuestionsController extends GetxController {
  final questiosPagingController =
      PagingController<int, Question>(firstPageKey: 1);

  final RxString searchQuery = ''.obs;
  late Worker searchDebounce;

  @override
  void onInit() {
    super.onInit();
    questiosPagingController.addPageRequestListener((page) async {
      await fetchQuestions(page);
      searchDebounce = debounce(
        searchQuery,
        (value) {
          questiosPagingController.refresh();
        },
        time: const Duration(seconds: 2),
      );
    });
  }

  Future<void> fetchQuestions(int pageKey) async {
    try {
      final newPage = await QuestionServices.userQuestions(
        page: pageKey,
        name: searchQuery.value.isEmpty ? null : searchQuery.value,
      );

      final newItems = newPage.questions;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        questiosPagingController.appendLastPage(newItems!);
      } else if (questiosPagingController.nextPageKey != newPage.nextPage) {
        questiosPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      questiosPagingController.error = e;
    }
  }

  void onDeleteCompleted(
      Map<String, dynamic>? resultData, BuildContext context) {
    if (resultData != null) {
      final Question newQuestion = Question.fromJson(
          resultData['deleteQuestion'] as Map<String, dynamic>);

      questiosPagingController.itemList!.remove(newQuestion);
      questiosPagingController.refresh();
      Navigator.pop(context);
    }
  }

  @override
  void onClose() {
    questiosPagingController.dispose();
    searchDebounce.dispose();
    super.onClose();
  }
}
