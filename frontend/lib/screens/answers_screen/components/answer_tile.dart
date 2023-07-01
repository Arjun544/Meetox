import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/answer_model.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/online_indicator.dart';

class AnswerTile extends StatelessWidget {
  final Answer answer;

  const AnswerTile({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
