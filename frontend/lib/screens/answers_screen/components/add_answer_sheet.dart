import 'package:frontend/controllers/answers_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/question/mutation.dart';
import 'package:frontend/models/answer_model.dart';
import 'package:frontend/widgets/custom_area_field.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/loaders/botton_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddAnswerSheet extends HookWidget {
  final String id;
  final String name;

  const AddAnswerSheet({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final AnswersController answersController = Get.find();
    final textCotroller = useTextEditingController();
    final addAnswerMutation = useMutation(
      MutationOptions(
        document: gql(addAnswer),
        onCompleted: (data) {
          if (data != null && data['addAnswer'] != null) {
            answersController.answersPagingController.itemList!.insert(
              0,
              Answer.fromJson(data['addAnswer']),
            );
            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            answersController.answersPagingController.notifyListeners();
            Navigator.pop(context);
          }
        },
      ),
    );

    return Container(
      height: Get.height * 0.3,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Answer ',
                style: context.theme.textTheme.labelSmall!,
                children: [
                  TextSpan(
                    text: name.capitalizeFirst,
                    style: context.theme.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "'s question",
                    style: context.theme.textTheme.labelSmall!,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.sp),
            Expanded(
              child: CustomAreaField(
                hintText: 'Write your answer',
                controller: textCotroller,
                focusNode: FocusNode(),
                hasFocus: true.obs,
                autoFocus: true,
                text: ''.obs,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Asnwer can't be empty";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20.sp),
            addAnswerMutation.result.isLoading
                ? Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: ButtonLoader(
                      height: 35.h,
                      width: Get.width * 0.3,
                    ),
                  )
                : CustomButton(
                    height: 35.h,
                    width: Get.width * 0.3,
                    marginBottom: 10.h,
                    text: 'Submit',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        addAnswerMutation.runMutation({
                          "id": id,
                          "answer": textCotroller.text.trim(),
                        });
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
