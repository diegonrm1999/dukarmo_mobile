import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/domain/order_treatment.dart';
import 'package:flutter/material.dart';

class OrderTreatmentList extends StatelessWidget {
  final List<OrderTreatment> treatments;

  const OrderTreatmentList({super.key, required this.treatments});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Tratamientos", style: TextStyleWrapper.mdBold),
            const SizedBox(height: 12),
            ...treatments.map((t) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.spa, color: AppColors.primaryButton),
                title: Text(t.treatment.name, style: TextStyleWrapper.mdBlack),
                trailing: Text(
                  "S/.${t.price.toStringAsFixed(2)}",
                  style: TextStyleWrapper.mdBold,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
