import 'package:flutter/material.dart';

/*
Absolutely! Let's continue expanding the ResponsiveText class with more text styles commonly used in Flutter applications. 
This will further enhance the versatility and adaptability of your app's text across different screen sizes and orientations.
*/

class ResponsiveText {
  static double textSize(BuildContext context, double baseSize) {
    double scaleFactor = MediaQuery.of(context).size.width /
        375.0; // Adjust 375.0 as your base screen width
    return baseSize * scaleFactor;
  }

  static TextStyle headline(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 24.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  static TextStyle subhead(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 18.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle bodyText(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 14.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle caption(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 12.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }

  static TextStyle button(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 16.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  static TextStyle appBarTitle(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 20.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  static TextStyle hintText(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 14.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.normal,
      fontStyle: FontStyle.italic,
      color: Colors.grey[400],
    );
  }

  static TextStyle errorText(BuildContext context,
      {double? fontSize, FontWeight? fontWeight}) {
    double size = fontSize ?? 12.0;
    return TextStyle(
      fontSize: textSize(context, size),
      fontWeight: fontWeight ?? FontWeight.normal,
      color: Colors.red,
    );
  }

  // Add more text styles as needed
}
