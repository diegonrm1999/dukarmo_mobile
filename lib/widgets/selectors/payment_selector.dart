import 'package:flutter/material.dart';
import 'package:dukarmo_app/enums/payment_method.dart';

class PaymentMethodSelector extends StatelessWidget {
  final PaymentMethod? selectedMethod;
  final void Function(PaymentMethod) onTap;
  final List<PaymentMethod> methods;
  const PaymentMethodSelector({
    super.key,
    required this.selectedMethod,
    required this.onTap,
    required this.methods,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...methods.map((method) {
          final isSelected = selectedMethod == method;
          return GestureDetector(
            onTap: () => onTap(method),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.black : Colors.grey.shade300,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    method.displayName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Icon(
                    isSelected
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: isSelected ? Colors.black : Colors.grey,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
