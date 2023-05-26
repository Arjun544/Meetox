import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/utils/constants.dart';

class CustomMarker extends HookWidget {
  const CustomMarker({
    required this.color,
    required this.user,
    required this.onPressed,
    super.key,
    this.isQuestionMarker = false,
  });
  final User user;
  final Color color;
  final bool isQuestionMarker;
  final void Function(ValueNotifier<User>)? onPressed;

  @override
  Widget build(BuildContext context) {
    final tappedUser = useState(User());

    return AnimatedScale(
      scale: tappedUser.value.id != null ? 1.7 : 1,
      duration: const Duration(milliseconds: 400),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              tappedUser.value = user;
              onPressed!(tappedUser);
            },
            child: !isQuestionMarker
                ? Container(
                    width: 40.sp,
                    height: 40.sp,
                    decoration: BoxDecoration(
                      color: AppColors.customGrey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 3,
                        color: color,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          user.displayPic!.profile!.isEmpty
                              ? profilePlaceHolder
                              : user.displayPic!.profile!,
                        ),
                      ),
                    ),
                  )
                : Container(
                    width: 40.sp,
                    height: 40.sp,
                    decoration: BoxDecoration(
                      color: isQuestionMarker
                          ? Colors.green
                          : AppColors.customGrey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 3,
                        color: color,
                      ),
                    ),
                    child: Icon(
                      FlutterRemix.question_fill,
                      color: Colors.white,
                      size: 35.sp,
                    ),
                  ),
          ),
          Positioned(
            bottom: -15,
            child: Icon(
              FlutterRemix.arrow_down_s_fill,
              size: 25.sp,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
