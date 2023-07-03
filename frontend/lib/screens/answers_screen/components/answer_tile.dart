import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/question/mutation.dart';
import 'package:frontend/models/answer_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AnswerTile extends HookWidget {
  final Answer answer;

  const AnswerTile({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<String>> likes = useState(answer.likes!);

    final likeAnswerMutaion = useMutation(
      MutationOptions(
        document: gql(toggleLikeAnswer),
        onCompleted: (data) {
          if (data != null && data['toggleLikeAnswer'] != null) {
            if (likes.value.contains(currentUser.value.id!)) {
              likes.value.remove(currentUser.value.id!);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              likes.notifyListeners();
            } else {
              likes.value.add(currentUser.value.id!);
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              likes.notifyListeners();
            }
          }
        },
      ),
    );
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: context.theme.indicatorColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.w),
        leading: Stack(
          children: [
            Container(
              width: 40.sp,
              height: 40.sp,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    answer.user!.displayPic!.profile == ''
                        ? profilePlaceHolder
                        : answer.user!.displayPic!.profile!,
                  ),
                ),
              ),
            ),
            OnlineIndicator(id: answer.user!.userId!),
          ],
        ),
        title: Text(
          answer.user!.name == '' ? 'Unknown' : answer.user!.name!.capitalize!,
          overflow: TextOverflow.ellipsis,
          style: context.theme.textTheme.labelSmall!.copyWith(
            color: context.theme.textTheme.labelSmall!.color!.withOpacity(0.5),
          ),
        ),
        subtitle: Text(
          answer.answer!.capitalize!,
          style: context.theme.textTheme.labelSmall,
        ),
        trailing: GestureDetector(
          onTap: likeAnswerMutaion.result.isLoading
              ? () {}
              : () {
                  likeAnswerMutaion.runMutation({
                    'id': answer.id,
                  });
                },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                IconsaxBold.like_1,
                color: likes.value.contains(currentUser.value.id!)
                    ? Colors.blue
                    : Colors.blueGrey,
                size: 18,
              ),
              if (likes.value.isNotEmpty) ...[
                const SizedBox(
                  width: 5,
                ),
                Text(
                  likes.value.length.toString(),
                  style: context.theme.textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
