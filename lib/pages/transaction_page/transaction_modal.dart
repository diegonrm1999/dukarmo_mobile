import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_modal_content.dart';
import 'package:dukarmo_app/widgets/status_page_content.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/utils/date_formatter.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_modal_controller.dart';
import 'package:provider/provider.dart';

class TransactionDetailModal extends StatelessWidget {
  const TransactionDetailModal({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionModalController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
      child: SizedBox(
        width: double.infinity,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 300, maxHeight: 300),
          child: StatusPageContent(
            status: controller.statusPage,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Detalles de la Orden',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TransactionModalContent(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
