import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/utils/constants.dart';
import 'package:frontend/widgets/custom_button.dart';
import 'package:frontend/widgets/custom_field.dart';

class PasswordlessAutScreen extends StatefulWidget {
  const PasswordlessAutScreen({super.key});

  @override
  State<PasswordlessAutScreen> createState() => _PasswordlessAutScreenState();
}

class _PasswordlessAutScreenState extends State<PasswordlessAutScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  RxBool hasEmailFocus = false.obs;

  @override
  void initState() {
    emailFocusNode
      ..requestFocus()
      ..addListener(() {
        hasEmailFocus.value = emailFocusNode.hasFocus;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: emailFocusNode.unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.theme.appBarTheme.backgroundColor,
          elevation: 0,
          systemOverlayStyle: context.theme.appBarTheme.systemOverlayStyle,
          iconTheme: context.theme.appBarTheme.iconTheme,
        ),
        body: Padding(
          padding: globalHorizentalPadding,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SlideInLeft(
                      child: SvgPicture.asset(
                        AssetsManager.appLogo,
                        color: AppColors.primaryYellow,
                        height: 70.h,
                      ),
                    ),
                    SizedBox(height: 40.sp),
                    Text(
                      'Enter a valid email, we will sent you a magic code to login or signup.',
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.labelSmall,
                    ),
                    SizedBox(height: 40.sp),
                    CustomField(
                      hintText: 'Email',
                      controller: emailController,
                      focusNode: emailFocusNode,
                      prefixIcon: FlutterRemix.mail_fill,
                      isPasswordVisible: true.obs,
                      hasFocus: hasEmailFocus,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          emailFocusNode.requestFocus();
                          return 'Please enter email';
                        } else if (!text.trim().isEmail) {
                          emailFocusNode.requestFocus();
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                CustomButton(
                  width: Get.width * 0.7,
                  text: 'Send code',
                  color: context.theme.cardColor,
                  marginBottom: 20.sp,
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      // await AuthServices.loginWithPasswordless(
                      //   email: emailController.text
                      //       .trim()
                      //       .toLowerCase(),
                      //   isLoading: isLoading,
                      // );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
