import 'package:flutter/material.dart';

class ReusableWidget extends StatelessWidget {
  final String label;

  ReusableWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
