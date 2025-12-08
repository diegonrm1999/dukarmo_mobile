import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/domain/client.dart';
import 'package:dukarmo_app/domain/user.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';

class OrderClientInfo extends StatelessWidget {
  final Client client;
  final User stylist;
  final User cashier;

  const OrderClientInfo({
    super.key,
    required this.client,
    required this.stylist,
    required this.cashier,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Información del cliente",
              style: TextStyleWrapper.mdBold,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppColors.primaryButton,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    client.name,
                    style: TextStyleWrapper.mdBlack,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (client.phone != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: AppColors.primaryButton,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      client.phone!,
                      style: TextStyleWrapper.mdBlack,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            const Divider(height: 24),
            Row(
              children: [
                const Icon(
                  Icons.content_cut,
                  color: AppColors.primaryButton,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Estilista: ${stylist.firstName} ${stylist.lastName}",
                    style: TextStyleWrapper.mdBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(
                  Icons.attach_money,
                  color: AppColors.primaryButton,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Cajero: ${cashier.firstName} ${cashier.lastName}",
                    style: TextStyleWrapper.mdBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
