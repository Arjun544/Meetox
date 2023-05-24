import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/screens/add_circle_screen/add_circle_screen.dart';

class AddOptionsSheet extends StatelessWidget {
  const AddOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.28,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        color: context.theme.bottomSheetTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                IconsaxBold.document_text,
                color: AppColors.primaryYellow,
              ),
            ),
            title: Text(
              'Add post',
              style: context.theme.textTheme.labelMedium,
            ),
          ),
          SizedBox(height: 20.sp),
          ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                FlutterRemix.bubble_chart_fill,
                color: Colors.lightBlue,
              ),
            ),
            title: Text(
              'Create circle',
              style: context.theme.textTheme.labelMedium,
            ),
            onTap: () => Get.to(() => const AddCircleScreen()),
          ),
          SizedBox(height: 20.sp),
          ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            dense: true,
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                FlutterRemix.question_mark,
                color: Colors.green,
              ),
            ),
            title: Text(
              'Ask question',
              style: context.theme.textTheme.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
