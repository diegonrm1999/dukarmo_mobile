import 'package:flutter/material.dart';

class PaymentTile extends StatelessWidget {
  final String amount;
  final String label;
  final IconData icon;

  const PaymentTile({
    super.key,
    required this.amount,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(blurRadius: 4, offset: Offset(0, 1), color: Colors.black12),
        ],
        border: Border.all(
          color: Color(0xFFE0E0E0),
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.pink, size: 28),
          const SizedBox(height: 10),
          Text(
            amount,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
