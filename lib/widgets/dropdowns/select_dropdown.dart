import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';

class SelectDropdown<T> extends StatelessWidget {
  final String? selectedItem;
  final String? hintText;
  final List<T> items;
  final String Function(T) displayText;
  final String Function(T) valueSelector;
  final void Function(String?) onChanged;

  const SelectDropdown({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    required this.valueSelector,
    required this.displayText,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F5),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DropdownButtonFormField<String>(
            value: selectedItem,
            onChanged: onChanged,
            decoration: const InputDecoration(border: InputBorder.none),
            hint: hintText != null
                ? Text(hintText!, style: TextStyleWrapper.mdBlackRegular)
                : null,
            style: TextStyleWrapper.mdBlack,
            icon: const Icon(Icons.expand_more, color: Colors.grey),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: valueSelector(item),
                child: Text(displayText(item)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
