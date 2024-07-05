import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppTextStyles {
  static final TextStyle onBoardingTitle = GoogleFonts.sourceSans3(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    // color: AppColors.white,
  );

  static final TextStyle onBoardingSubTitle = GoogleFonts.sourceSans3(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static final TextStyle buttonText = GoogleFonts.sourceSans3(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle bodyText = GoogleFonts.sourceSans3(
    fontSize: 14.0,
  );

  static final TextStyle bodyText2 = GoogleFonts.sourceSans3(
    fontSize: 19.0,
  );

  static final TextStyle headline1 = GoogleFonts.sourceSans3(
    fontSize: 26.0,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle headline = GoogleFonts.sourceSans3(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  // Add more text styles as needed
}
