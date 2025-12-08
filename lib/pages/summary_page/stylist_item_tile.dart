import 'package:flutter/material.dart';

class StylistItemTile extends StatelessWidget {
  final String name;
  final int orders;

  const StylistItemTile({super.key, required this.name, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(blurRadius: 4, offset: Offset(0, 1), color: Colors.black12),
        ],
        border: Border.all(
          color: Color(0xFFE0E0E0),
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '$orders',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }
}
