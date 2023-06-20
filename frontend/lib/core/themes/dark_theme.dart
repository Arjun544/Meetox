import 'package:frontend/core/imports/core_imports.dart';
import 'package:frontend/core/imports/packages_imports.dart';
import 'package:frontend/core/text_styles.dart';
import 'package:frontend/utils/constants.dart';

final ThemeData darkTheme = ThemeData.light().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColors.primaryYellow.withOpacity(0.5),
    selectionHandleColor: AppColors.primaryYellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
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
  indicatorColor: AppColors.customBlack,
  canvasColor: AppColors.customGrey,
  dialogBackgroundColor: Colors.black,
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
    fillColor: AppColors.customBlack,
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
  tabBarTheme: TabBarTheme(
    labelStyle: globalTextStyle(
      fontSize: 12.sp,
      color: AppColors.primaryYellow,
      fontWeight: FontWeight.w600,
    ),
    unselectedLabelStyle: globalTextStyle(
      fontSize: 12.sp,
      color: const Color(0xFF868590),
      fontWeight: FontWeight.w600,
    ),
    labelColor: AppColors.primaryYellow,
    unselectedLabelColor: const Color(0xFF8E8E91),
    labelPadding: const EdgeInsets.symmetric(vertical: 6),
    indicator: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: AppColors.customBlack,
  ),
);
