import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.orderNumber,
    required this.clientName,
    this.onItemTap,
    required this.operatorName,
    this.backgroundColor = AppColors.primaryButton,
    required this.totalPrice,
    required this.date,
  });

  final String orderNumber;
  final String clientName;
  final VoidCallback? onItemTap;
  final String operatorName;
  final Color? backgroundColor;
  final double totalPrice;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: GestureDetector(
        onTap: onItemTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white.withAlpha(51),
                  child: const Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Orden #$orderNumber',
                        style: TextStyleWrapper.smRegularWhite.copyWith(
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(clientName, style: TextStyleWrapper.mdBoldWhite),
                      const SizedBox(height: 4),
                      Text(
                        'Profesional: $operatorName',
                        style: TextStyleWrapper.smRegularWhite,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: TextStyleWrapper.smRegularWhite.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'S/${totalPrice.toStringAsFixed(2)}',
                      style: TextStyleWrapper.mdBoldWhite.copyWith(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
