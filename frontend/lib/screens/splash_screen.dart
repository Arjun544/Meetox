import 'package:frontend/controllers/global_controller.dart';
import 'package:frontend/controllers/splash_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/user/queries.dart';
import 'package:frontend/helpers/show_toast.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/auth_screens/screens_imports.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get
      ..put(SplashController())
      ..put(GlobalController(), permanent: true);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryYellow,
              Colors.yellow[200]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.shrink(),
            Column(
              children: [
                Query<User>(
                  options: QueryOptions(
                    document: gql(getUser),
                    fetchPolicy: FetchPolicy.networkOnly,
                    parserFn: User.fromJson,
                    variables: const {
                      'id': null,
                    },
                    onComplete: (Map<String, dynamic>? data) {
                      logSuccess(data.toString());
                      if (data != null && data['getUser'] != null) {
                        final getUser = data['getUser'] as Map<String, dynamic>;
                        final user = User.fromJson(getUser);
                        currentUser.value = user;
                        // ignore: invalid_use_of_protected_member
                        currentUser.refresh();
                        controller.onCompleted(user);
                      } else {
                        Get.offAll(() => const AuthScreen());
                      }
                    },
                    onError: (error) {
                      logError(error!.graphqlErrors.toString());
                      if (error.graphqlErrors.isNotEmpty &&
                          error.graphqlErrors[0].message == 'jwt expired') {
                        showToast('Session expired, please login again');
                        Get.offAll(() => const AuthScreen());
                      }
                    },
                  ),
                  builder: (
                    QueryResult<User> result, {
                    VoidCallback? refetch,
                    FetchMore? fetchMore,
                  }) {
                    return Swing(
                      infinite: true,
                      child: Hero(
                        tag: 'Logo',
                        child: SvgPicture.asset(
                          AssetsManager.appLogo,
                          height: 50.h,
                          colorFilter: const ColorFilter.mode(
                            AppColors.customBlack,
                            BlendMode.srcIn,
                          ),
                          theme: const SvgTheme(
                            currentColor: AppColors.customBlack,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 14.h),
                Text(
                  'Meetox',
                  style: context.theme.textTheme.titleLarge!.copyWith(
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.customBlack,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: LoadingAnimationWidget.threeArchedCircle(
                color: AppColors.customBlack,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
