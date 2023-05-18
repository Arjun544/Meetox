import 'dart:convert';

import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/graphql/auth/mutation.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/add_profile_screen/add_profile_screen.dart';
import 'package:frontend/screens/auth_screens/screens_imports.dart';
import 'package:frontend/screens/drawer_screen.dart';
import 'package:frontend/services/secure_storage_service.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/loaders/botton_loader.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.appBarTheme.backgroundColor,
        elevation: 0,
        systemOverlayStyle: context.theme.appBarTheme.systemOverlayStyle,
        iconTheme: context.theme.appBarTheme.iconTheme,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Hero(
                    tag: 'Logo',
                    child: SvgPicture.asset(
                      AssetsManager.appLogo,
                      height: 70.h,
                      color: AppColors.primaryYellow,
                    ),
                  ),
                  SizedBox(height: 50.sp),
                  Text(
                    'Get ready to meet',
                    style: context.theme.textTheme.titleMedium,
                  ),
                  Text(
                    'Your next best match',
                    style: context.theme.textTheme.titleMedium!
                        .copyWith(color: AppColors.primaryYellow),
                  ),
                ],
              ),
              SizedBox(height: 100.sp),
              Column(
                children: [
                  FadeInUp(
                    child: ElasticIn(
                      duration: const Duration(seconds: 2),
                      child: SlideInUp(
                        delay: const Duration(seconds: 1),
                        duration: const Duration(milliseconds: 400),
                        from: 280,
                        child: CustomButton(
                          width: Get.width * 0.9,
                          text: 'Continue with Passwordless',
                          color: context.theme.cardColor,
                          hasIcon: true,
                          icon: IconTheme(
                            data: context.theme.iconTheme
                                .copyWith(color: AppColors.customBlack),
                            child: const Icon(
                              FlutterRemix.magic_fill,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async =>
                              Get.to(() => const PasswordlessAutScreen()),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  FadeInUp(
                    child: ElasticIn(
                      duration: const Duration(seconds: 2),
                      child: SlideInUp(
                        delay: const Duration(seconds: 1),
                        from: 300,
                        duration: const Duration(milliseconds: 400),
                        child: CustomButton(
                          width: Get.width * 0.9,
                          text: 'Continue with WhatsApp',
                          color: Colors.teal,
                          hasIcon: true,
                          icon: IconTheme(
                            data: context.theme.iconTheme
                                .copyWith(color: AppColors.customBlack),
                            child: const Icon(
                              FlutterRemix.whatsapp_fill,
                              color: AppColors.customBlack,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.sp,
              ),
              FadeInUp(
                child: ElasticIn(
                  duration: const Duration(seconds: 2),
                  child: SlideInUp(
                    delay: const Duration(seconds: 1),
                    duration: const Duration(milliseconds: 400),
                    from: 330,
                    child: Mutation(
                      options: MutationOptions(
                        document: gql(loginWithGmail),
                        fetchPolicy: FetchPolicy.networkOnly,
                        update: (cache, result) => cache,
                        onCompleted: (Map<String, dynamic>? resultData) async {
                          logSuccess(json.encode(resultData));
                          logError(
                            resultData!['loginWithGmail']['token'].toString(),
                          );
                          final token =
                              resultData['loginWithGmail']['token'].toString();
                          final user = User.fromJson(
                            resultData['loginWithGmail']['user']
                                as Map<String, dynamic>,
                          );

                          await SecureStorageServices.putValue(
                            key: 'accessToken',
                            value: token,
                          );
                          await SecureStorageServices.putValue(
                            key: 'currentLoginProvider',
                            value: 'Google',
                          );

                          if (user.name!.isEmpty) {
                            await Get.offAll(() => const AddProfileScreen());
                          } else {
                            await Get.offAll(() => const DrawerScreen());
                          }
                          currentUser.value = user;
                          final authLink = AuthLink(
                            getToken: () async => 'Bearer $token',
                          );
                          graphqlClient!.value.link.concat(authLink);
                          final websocketLink = WebSocketLink(
                            'ws://192.168.1.181:4000/graphql/subscriptions',
                            config: SocketClientConfig(
                              initialPayload: {
                                'id': currentUser.value.id,
                                'token': token,
                              },
                            ),
                          );
                          final httpLink = HttpLink(
                            'http://192.168.1.181:4000/graphql',
                          );

                          final link =
                              httpLink.concat(authLink).concat(websocketLink);
                          final newLink = Link.split(
                            (request) => request.isSubscription,
                            websocketLink,
                            link,
                          );
                          graphqlClient = ValueNotifier(
                            GraphQLClient(
                              link: newLink,
                              cache: GraphQLCache(store: HiveStore()),
                            ),
                          );
                        },
                        onError: (error) => logError('Unable to login'),
                      ),
                      builder: (runMutation, result) {
                        return Obx(
                          () => controller.isLoading.value || result!.isLoading
                              ? ButtonLoader(
                                  width: Get.width * 0.9,
                                  color: Colors.redAccent[100]!,
                                  loaderColor: Colors.white,
                                )
                              : CustomButton(
                                  width: Get.width * 0.9,
                                  text: 'Continue with Google',
                                  hasIcon: true,
                                  color: Colors.redAccent[100]!,
                                  icon: IconTheme(
                                    data: context.theme.iconTheme,
                                    child: const Icon(
                                      FlutterRemix.google_fill,
                                    ),
                                  ),
                                  onPressed: () =>
                                      controller.handleLoginWithGmail(
                                    runMutation,
                                    result,
                                  ),

                                  
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              FadeInUp(
                child: ElasticIn(
                  duration: const Duration(seconds: 2),
                  child: SlideInUp(
                    delay: const Duration(seconds: 1),
                    duration: const Duration(milliseconds: 400),
                    from: 350,
                    child: CustomButton(
                      width: Get.width * 0.9,
                      icon: IconTheme(
                        data: context.theme.iconTheme,
                        child: const Icon(
                          FlutterRemix.facebook_fill,
                        ),
                      ),
                      hasIcon: true,
                      color: Colors.blueAccent[100]!,
                      text: 'Continue with Facebook',
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.sp),
              FadeInUp(
                child: ElasticIn(
                  duration: const Duration(seconds: 2),
                  child: SlideInUp(
                    delay: const Duration(seconds: 1),
                    duration: const Duration(milliseconds: 400),
                    from: 350,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By continuing, you accept our\n',
                        style: context.theme.textTheme.labelSmall!
                            .copyWith(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'privacy policy',
                            style: context.theme.textTheme.labelSmall!.copyWith(
                              color: AppColors.primaryYellow,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: context.theme.textTheme.labelSmall!
                                .copyWith(color: Colors.grey),
                          ),
                          TextSpan(
                            text: 'terms of services',
                            style: context.theme.textTheme.labelSmall!
                                .copyWith(color: AppColors.primaryYellow),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
