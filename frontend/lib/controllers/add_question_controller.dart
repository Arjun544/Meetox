import 'package:frontend/controllers/questions_cotroller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/models/question_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'global_controller.dart';
import 'root_controller.dart';

class AddQuestionController extends GetxController {
  final GlobalController globalController = Get.find();
  final RootController rootController = Get.find();
  final PageController pageController = PageController();

  final TextEditingController questionController = TextEditingController();
  final RxString questionText = ''.obs;

  final FocusNode questionFocusNode = FocusNode();

  final RxBool hasQuestionFocus = false.obs;

  final RxInt currentStep = 0.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void handleAddQuestion(BuildContext context, dynamic runMutation,
      QueryResult<Object?>? result) async {
    runMutation(
      {
        'question': questionController.text.trim(),
        'location': {
          'address': currentUser.value.location!.address,
          'coordinates': [
            currentUser.value.location!.coordinates![0],
            currentUser.value.location!.coordinates![1],
          ],
        }
      },
    );
  }

  void onComplete(Map<String, dynamic>? resultData) {
    if (resultData != null) {
      logSuccess(resultData.toString());
      final bool hasQuestionsController =
          Get.isRegistered<QuestionsController>();
      if (hasQuestionsController) {
        final Question newQuestion = Question.fromJson(
            resultData['addQuestion'] as Map<String, dynamic>);
        final QuestionsController questionsController = Get.find();

        questionsController.questiosPagingController.itemList!
            .insert(0, newQuestion);
        questionsController.questiosPagingController
            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            .notifyListeners();
      }

      currentStep.value = 0;
      questionController.clear();
      questionText('');
      Get.back();
    }
  }
}
