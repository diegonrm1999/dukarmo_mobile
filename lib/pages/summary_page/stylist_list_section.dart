import 'package:dukarmo_app/domain/stylist_summary.dart';
import 'package:dukarmo_app/pages/summary_page/stylist_item_tile.dart';
import 'package:flutter/material.dart';

class StylistListSection extends StatelessWidget {
  final List<StylistSummary> stylists;

  const StylistListSection({super.key, required this.stylists});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ordenes por Especialista',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 220,
          child: ListView.separated(
            itemCount: stylists.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final s = stylists[index];
              return StylistItemTile(name: s.stylistName, orders: s.count);
            },
          ),
        ),
      ],
    );
  }
}
