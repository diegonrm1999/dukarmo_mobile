import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/widgets/textfields/primary_text_field.dart';

class TitleTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isNumberField;

  const TitleTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.textController,
    this.keyboardType,
    this.validator,
    this.isNumberField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(title, style: TextStyleWrapper.lgRegular),
        SizedBox(height: 10),
        PrimaryTextField(
          validator: validator,
          hintText: hintText,
          controller: textController,
          keyboardType: keyboardType,
          isNumberField: isNumberField,
        ),
      ],
    );
  }
}
