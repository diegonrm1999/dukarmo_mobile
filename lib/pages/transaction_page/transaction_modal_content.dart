import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_modal_controller.dart';
import 'package:flutter/material.dart';

class TransactionModalContent extends StatelessWidget {
  final TransactionModalController controller;

  const TransactionModalContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.pink),
            SizedBox(width: 8),
            Text('Fecha: ${controller.order?.createdAt ?? ""}'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.person, color: Colors.pink),
            SizedBox(width: 8),
            Text('Cliente: ${controller.order?.client.name ?? ""}'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.content_cut, color: Colors.pink),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Servicio: ${controller.serviceNames}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.attach_money, color: Colors.pink),
            SizedBox(width: 8),
            Text(
              'Precio: S/ ${controller.order?.totalPrice.toStringAsFixed(2) ?? ""}',
            ),
          ],
        ),
        SizedBox(height: 24),
        ValueListenableBuilder<bool>(
          valueListenable: controller.isLoading,
          builder: (_, isLoading, __) => ElevatedButton.icon(
            onPressed: isLoading
                ? null
                : () => controller.restoreOrder(context),
            icon: Icon(Icons.restore),
            label: Text('Restaurar orden'),
            style: ElevatedButton.styleFrom(
              backgroundColor: isLoading
                  ? AppColors.homeBackground
                  : Colors.pink.shade300,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
