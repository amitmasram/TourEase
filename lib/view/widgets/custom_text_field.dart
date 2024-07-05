import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/utils/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String label;
  final IconData? icon;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      this.icon,
      required this.hintText,
      required this.controller,
      required this.label,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: AppTextStyles.bodyText),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.bodyText,
              suffixIcon: icon == null ? null : Icon(icon),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              )),
        ),
      ],
    );
  }
}
