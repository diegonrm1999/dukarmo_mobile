import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool autocorrect;
  final TextInputType? keyboardType;
  final bool centerHintText;
  final bool isNumberField;
  final String? Function(String?)? validator;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.autocorrect = false,
    this.centerHintText = false,
    this.keyboardType = TextInputType.text,
    this.isNumberField = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      autocorrect: autocorrect,
      style: TextStyleWrapper.mdBlack,
      obscureText: obscureText,
      inputFormatters: isNumberField
          ? [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))]
          : null,
      keyboardType: keyboardType,
      textAlign: centerHintText ? TextAlign.center : TextAlign.start,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyleWrapper.mdBlackRegular,

        labelStyle: TextStyleWrapper.mdBlack,
        fillColor: AppColors.textFieldBackground,
        errorStyle: TextStyle(height: 0),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
