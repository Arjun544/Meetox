import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/models/answer_model.dart';
import 'package:frontend/services/question_services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';


class AnswersController extends GetxController {
  final String id;
  AnswersController(this.id);

  final answersPagingController =
      PagingController<int, Answer>(firstPageKey: 1);

  @override
  void onInit() {
    super.onInit();
    answersPagingController.addPageRequestListener((page) async {
      await fetchAnswers(page);
    });
  }

  Future<void> fetchAnswers(int pageKey) async {
    try {
      final newPage = await QuestionServices.questionAnswers(
        id: id,
        page: pageKey,
      );

      final newItems = newPage.answers;

      if (newPage.nextPage == null &&
          !newPage.hasNextPage! &&
          newPage.nextPage == newPage.page) {
        answersPagingController.appendLastPage(newItems!);
      } else if (answersPagingController.nextPageKey != newPage.nextPage) {
        answersPagingController.appendPage(newItems!, newPage.nextPage);
      }
    } catch (e) {
      logError(e.toString());
      answersPagingController.error = e;
    }
  }

  @override
  void onClose() {
    answersPagingController.dispose();
    super.onClose();
  }
}
