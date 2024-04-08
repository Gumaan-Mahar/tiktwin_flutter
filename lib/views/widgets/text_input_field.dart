import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;
  const TextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(
          fontSize: 20,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: AppColors.borderColor,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      obscureText: isObscure,
    );
  }
}
