import 'package:flutter/material.dart';

class Space {
  static Widget vertical(double height) {
    return SizedBox(height: height);
  }

  static Widget horizontal(double width) {
    return SizedBox(width: width);
  }
}
