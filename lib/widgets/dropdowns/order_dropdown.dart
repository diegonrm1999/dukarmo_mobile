import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/widgets/dropdowns/select_dropdown.dart';
import 'package:provider/provider.dart';

class OrderDropdown<T extends ChangeNotifier> extends StatelessWidget {
  final String fieldTitle;
  final String? hintText;
  final String? Function(T controller) selectedItem;
  final List<dynamic> Function(T controller) items;
  final String Function(dynamic item, T controller) valueSelector;
  final String Function(dynamic item, T controller) displayText;
  final void Function(String?, T controller) onChanged;
  final String? Function(String?)? validator;


  const OrderDropdown({
    super.key,
    required this.fieldTitle,
    required this.selectedItem,
    required this.valueSelector,
    required this.displayText,
    required this.items,
    this.hintText,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(fieldTitle, style: TextStyleWrapper.lgRegular),
        SizedBox(height: 10),
        Consumer<T>(
          builder: (_, controller, __) {
            return SelectDropdown(
              selectedItem: selectedItem(controller),
              valueSelector: (item) => valueSelector(item, controller),
              displayText: (item) => displayText(item, controller),
              items: items(controller),
              hintText: hintText,
              onChanged: (val) => onChanged(val, controller),
            );
          },
        ),
      ],
    );
  }
}
