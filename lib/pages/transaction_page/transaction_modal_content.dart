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
            const Icon(Icons.calendar_today, color: Colors.pink, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Fecha: ${controller.order?.createdAt ?? ""}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.person, color: Colors.pink, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Cliente: ${controller.order?.client.name ?? ""}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.content_cut, color: Colors.pink, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Servicio: ${controller.serviceNames}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.attach_money, color: Colors.pink, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Precio: S/ ${controller.order?.totalPrice.toStringAsFixed(2) ?? ""}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ValueListenableBuilder<bool>(
          valueListenable: controller.isLoading,
          builder: (_, isLoading, __) => SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading
                  ? null
                  : () => controller.restoreOrder(context),
              icon: const Icon(Icons.restore),
              label: const Text('Restaurar orden'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLoading
                    ? AppColors.homeBackground
                    : Colors.pink.shade300,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
