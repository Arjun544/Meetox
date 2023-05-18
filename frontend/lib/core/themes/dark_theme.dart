import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/text_styles.dart';
import 'package:frontend/utils/constants.dart';

final ThemeData darkTheme = ThemeData.light().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.customBlack,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColors.primaryYellow.withOpacity(0.5),
    selectionHandleColor: AppColors.primaryYellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.customBlack,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: AppColors.customBlack,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
    titleTextStyle: globalTextStyle(
      fontSize: headingThreeFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 20.sp,
    ),
  ),
  cardColor: Colors.black,
  dividerColor: Colors.black,
  backgroundColor: Colors.black45,
  dialogBackgroundColor: AppColors.customBlack,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.black,
  ),
  iconTheme: IconThemeData(
    color: Colors.white,
    size: 20.sp,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColors.customBlack,
    linearTrackColor: AppColors.primaryYellow,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodySmall: globalTextStyle(
      fontSize: headingLargeFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: globalTextStyle(
      fontSize: headingOneFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: globalTextStyle(
      fontSize: headingTwoFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: globalTextStyle(
      fontSize: headingThreeFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: globalTextStyle(
      fontSize: headingFourFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: globalTextStyle(
      fontSize: headingFiveFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: globalTextStyle(
      fontSize: headingSixFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.black54,
    hintStyle: globalTextStyle(
      fontSize: headingSixFontSize,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    errorStyle: globalTextStyle(
      fontSize: headingSixFontSize,
      color: Colors.red,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.customBlack,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.customBlack,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
  ),
);
