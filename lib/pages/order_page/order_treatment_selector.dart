import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/domain/treatment.dart';
import 'package:dukarmo_app/domain/treatment_entry.dart';
import 'package:flutter/services.dart';

class OrderTreatmentSelector extends StatelessWidget {
  final List<Treatment> treatments;
  final List<TreatmentEntry> selectedServices;
  final Function() onAddEntry;
  final Function(int) onRemoveEntry;

  const OrderTreatmentSelector({
    super.key,
    required this.treatments,
    required this.selectedServices,
    required this.onAddEntry,
    required this.onRemoveEntry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...selectedServices.asMap().entries.map((entry) {
          final index = entry.key;
          final service = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      value: service.treatmentId,
                      hint: Text(
                        'Servicio',
                        style: TextStyleWrapper.mdBlackRegular,
                      ),
                      items: treatments.map((t) {
                        return DropdownMenuItem(
                          value: t.id,
                          child: Text(t.name, style: TextStyleWrapper.mdBlack),
                        );
                      }).toList(),
                      onChanged: (val) {
                        service.treatmentId = val;
                      },
                      style: TextStyleWrapper.mdBlack,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  flex: 1,
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    initialValue: service.price?.toString() ?? '',
                    onChanged: (val) {
                      service.price = double.tryParse(val);
                    },
                    decoration: InputDecoration(
                      hintText: "Precio",
                      hintStyle: TextStyleWrapper.mdBlackRegular,
                      labelStyle: TextStyleWrapper.mdBlack,
                      fillColor: AppColors.textFieldBackground,
                      errorStyle: TextStyle(height: 0),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                if (selectedServices.length > 1)
                  IconButton(
                    onPressed: () => onRemoveEntry(index),
                    icon: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
          );
        }),

        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onAddEntry,
            icon: Icon(Icons.add, color: Color(0xFFED6AB4)),
            label: Text(
              "Agregar servicio",
              style: TextStyle(
                color: Color(0xFFED6AB4),
                fontWeight: FontWeight.w500,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
      ],
    );
  }
}
