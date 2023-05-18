import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/widgets/custom_text_button.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({required this.email, super.key});
  final String email;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController pinController = TextEditingController();
  late final StreamDuration _streamDuration;
  final FocusNode focusNode = FocusNode();

  RxBool isShowingTimer = false.obs;
  RxBool isLoading = false.obs;

  @override
  void initState() {
    _streamDuration = StreamDuration(
      const Duration(minutes: 10),
      autoPlay: false,
      onDone: () {
        isShowingTimer.value = false;
      },
    );
    super.initState();
  }

  void handleVerification() {
    // AuthServices.verify(
    //   email: widget.email,
    //   code: pinController.text.trim(),
    //   isLoading: isLoading,
    // );
  }

  @override
  void dispose() {
    _streamDuration.dispose();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.sp,
      height: 56.sp,
      margin: const EdgeInsets.only(right: 12),
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        color: context.theme.inputDecorationTheme.fillColor,
      ),
    );
    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: SlideInDown(
                        child: Image.asset(
                          AssetsManager.mail,
                          height: 150.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'We sent a verification code to\n',
                        style: context.theme.textTheme.headline5,
                        children: [
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 90.sp),
                    SizedBox(
                      width: Get.width,
                      child: Pinput(
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        autofocus: true,
                        validator: (value) {
                          return null;
                        },
                        onClipboardFound: (value) {
                          debugPrint('onClipboardFound: $value');
                          pinController.setText(value);
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          handleVerification();
                        },
                        onChanged: (value) {},
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 2,
                              color: AppColors.primaryYellow,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: context.isDarkMode
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(19),
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 3,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: AppColors.primaryYellow.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(19),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.sp),
                    Obx(
                      () => isShowingTimer.value
                          ? Column(
                              children: [
                                Text(
                                  'Resend code after',
                                  style: context.theme.textTheme.headline5,
                                ),
                                SizedBox(height: 10.sp),
                                SlideCountdown(
                                  duration: const Duration(minutes: 10),
                                  streamDuration: _streamDuration,
                                  padding: const EdgeInsets.all(16),
                                  separatorPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,),
                                  textStyle: context.theme.textTheme.headline3!
                                      .copyWith(
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context
                                        .theme.inputDecorationTheme.fillColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            )
                          : CustomTextButton(
                              text: 'Resend',
                              color: Colors.blue,
                              onPressed: () async {
                                _streamDuration.play();
                                // await AuthServices.resendCode(
                                //   email: widget.email,
                                //   isLoading: isLoading,
                                //   isShowingTimer: isShowingTimer,
                                //   duration: _streamDuration,
                                // );
                              },
                            ),
                    ),
                    SizedBox(height: 60.sp),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
