import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/text_styles.dart';
import 'package:frontend/core/themes/colors.dart';
import 'package:frontend/utils/constants.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: AppColors.primaryYellow.withOpacity(0.5),
    selectionHandleColor: AppColors.primaryYellow,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
    titleTextStyle: globalTextStyle(
      fontSize: headingThreeFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    iconTheme: IconThemeData(
      color: AppColors.customBlack,
      size: 20.sp,
    ),
  ),
  cardColor: AppColors.customBlack,
  dividerColor: Colors.white,
  canvasColor: AppColors.customBlack,
  dialogBackgroundColor: AppColors.customGrey,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.customGrey,
  ),
  iconTheme: IconThemeData(
    color: AppColors.customBlack,
    size: 20.sp,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
    linearTrackColor: AppColors.primaryYellow,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.customGrey,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
  ),
  textTheme: TextTheme(
    bodySmall: globalTextStyle(
      fontSize: headingLargeFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: globalTextStyle(
      fontSize: headingOneFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: globalTextStyle(
      fontSize: headingTwoFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: globalTextStyle(
      fontSize: headingThreeFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: globalTextStyle(
      fontSize: headingFourFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: globalTextStyle(
      fontSize: headingFiveFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: globalTextStyle(
      fontSize: headingSixFontSize,
      color: AppColors.customBlack,
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.customGrey,
    hintStyle: globalTextStyle(
      fontSize: headingSixFontSize,
      color: AppColors.customBlack,
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
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);
