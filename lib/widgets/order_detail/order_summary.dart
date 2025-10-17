import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final double total;
  final double? paid;
  final VoidCallback? onSendReceipt;

  const OrderSummary({
    super.key,
    required this.total,
    required this.paid,
    this.onSendReceipt,
  });

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
            const Text("Resumen de pago", style: TextStyleWrapper.mdBold),
            const SizedBox(height: 12),
            _buildRow("Total", total, bold: true),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.grey.shade300,
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            if (onSendReceipt != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSendReceipt,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryButton,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  icon: const Icon(Icons.email_outlined, size: 20),
                  label: const Text(
                    "Enviar recibo",
                    style: TextStyleWrapper.mdBoldWhite,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String label,
    double value, {
    bool bold = false,
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: bold ? TextStyleWrapper.mdBold : TextStyleWrapper.mdBlack,
          ),
          Text(
            "S/.${value.toStringAsFixed(2)}",
            style: bold
                ? TextStyleWrapper.mdBold.copyWith(
                    color: highlight ? AppColors.error : Colors.black,
                  )
                : TextStyleWrapper.mdBlack,
          ),
        ],
      ),
    );
  }
}
