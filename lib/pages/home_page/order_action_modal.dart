import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:flutter/material.dart';

class OrderActionModal extends StatelessWidget {
  final String orderId;
  final UserRole currentRole;
  final void Function(String) onEdit;
  final void Function(String) onComplete;
  final void Function(String) onCancel;

  const OrderActionModal({
    super.key,
    required this.orderId,
    required this.onEdit,
    required this.onComplete,
    required this.onCancel,
    required this.currentRole,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.list_alt_rounded,
              size: 48,
              color: AppColors.primaryButton,
            ),
            const SizedBox(height: 16),
            const Text(
              '¿Qué deseas hacer con esta orden?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size.fromHeight(48),
              ),
              icon: const Icon(Icons.edit_rounded, color: Colors.white),
              label: const Text(
                'Editar orden',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onEdit(orderId);
              },
            ),
            if (currentRole == UserRole.Manager) ...[
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButton,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                icon: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                ),
                label: const Text(
                  'Completar orden',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  onComplete(orderId);
                },
              ),
            ],
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButton,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                minimumSize: const Size.fromHeight(48),
              ),
              icon: const Icon(Icons.cancel, color: Colors.white),
              label: const Text(
                'Cancelar orden',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onCancel(orderId);
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar', style: TextStyleWrapper.mdBold),
            ),
          ],
        ),
      ),
    );
  }
}
