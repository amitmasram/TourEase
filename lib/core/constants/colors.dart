import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
// App Basic Colors
  static const Color primary = Color(0xff5b25f6);
  static const Color secondary = Color(0xffc567f4);
  static const Color accent = Color(0xFFb0c7ff);

// Gradiant Colors

// Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6C7570);
  static const Color textWhite = Colors.white;

// Background Colors
  static const Color light = Color(0xFFF6F6F6);

  static const Color dark = Color(0xFF090909);
  static const Color primaryBackground = Color(0xFFF3F5FF);
  static const Color light2 = Color.fromARGB(255, 250, 246, 246);
// Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = AppColors.textWhite.withOpacity(0.1);

// Button Colors
  static const Color buttonPrimary = Color(0xff5b25f6);
  static const Color buttonSecondary = Color(0xFF6C7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

// Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

// Error and Validation Colors
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

// Neutral Shades
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softgrey = Color(0xFFF4F4F4);
  static const Color lightgrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  static const Color transparent = Color(0xFFD9D9D9);
  static const Color transparentBlack = Color(0xFF090909);
}

class GradientColors {
  // static const Color color1 = Color(0xff08000f);
  //static const Color color2 = Color(0xffd4b8fb);
  static const Color color3 = Color(0xffc567f4);
  static const Color color4 = Color(0xff5b25f6);
  static const Color color5 = Color(0xff91dcf9);

  static const LinearGradient gradient = LinearGradient(
    colors: [
      // color1,
      color4,
      // color2,
      color3,

      color5,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.topRight,
  );
}
