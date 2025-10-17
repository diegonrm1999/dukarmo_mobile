import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/widgets/modal/search_modal_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StylistSearchModal extends StatelessWidget {
  const StylistSearchModal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SearchModalController>();

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      behavior: HitTestBehavior.opaque,
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.90,
        builder: (_, scrollController) => GestureDetector(
          onTap: () {},
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.textController,
                    onChanged: controller.onSearchChanged,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primaryButton),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Consumer<SearchModalController>(
                      builder: (_, controller, __) {
                        final results = controller.stylistItems;
                        if (results.isEmpty) {
                          return const Center(
                            child: Text(
                              'No se encontraron profesionales',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: scrollController,
                          itemCount: results.length,
                          itemBuilder: (_, index) {
                            final stylist = results[index];
                            return InkWell(
                              onTap: () => Navigator.pop(context, stylist),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${stylist.firstName} ${stylist.lastName}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
