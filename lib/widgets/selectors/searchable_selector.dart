import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/domain/user.dart';
import 'package:dukarmo_app/widgets/modal/search_modal.dart';
import 'package:dukarmo_app/widgets/modal/search_modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchableStylistSelector extends StatelessWidget {
  final String? selectedStylistName;
  final List<User> stylistList;
  final void Function(User) onStylistSelected;

  const SearchableStylistSelector({
    super.key,
    required this.selectedStylistName,
    required this.onStylistSelected,
    required this.stylistList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final selected = await showModalBottomSheet<User>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ChangeNotifierProvider(
            create: (_) => SearchModalController(allStylists: stylistList),
            child: StylistSearchModal(),
          ),
        );

        if (selected != null) {
          onStylistSelected(selected);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedStylistName ?? 'Seleccionar profesional',
              style: TextStyleWrapper.mdBlack,
            ),
            const Icon(Icons.expand_more, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
