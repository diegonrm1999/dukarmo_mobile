import 'package:dukarmo_app/widgets/selectors/searchable_selector.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/domain/treatment_entry.dart';
import 'package:dukarmo_app/pages/order_page/order_controller.dart';
import 'package:dukarmo_app/pages/order_page/order_treatment_selector.dart';
import 'package:dukarmo_app/widgets/dropdowns/order_dropdown.dart';
import 'package:dukarmo_app/widgets/textfields/title_text_field.dart';
import 'package:provider/provider.dart';

class OrderContent extends StatelessWidget {
  final OrderController controller;

  const OrderContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder<List<TreatmentEntry>>(
          valueListenable: controller.selectedTreatments,
          builder: (context, selectedTreatments, _) {
            return OrderTreatmentSelector(
              treatments: controller.treatmentList,
              selectedServices: controller.selectedTreatments.value,
              onAddEntry: controller.onAddEntry,
              onRemoveEntry: controller.onRemoveEntry,
            );
          },
        ),
        SizedBox(height: 15),
        Text('Profesional', style: TextStyleWrapper.lgRegular),
        SizedBox(height: 10),
        Consumer<OrderController>(
          builder: (_, controller, __) {
            return SearchableStylistSelector(
              stylistList: controller.stylistList,
              selectedStylistName: controller.selectedStylist != null
                  ? controller.userName(controller.selectedStylist!)
                  : null,
              onStylistSelected: controller.onStylistSelected,
            );
          },
        ),
        SizedBox(height: 15),
        OrderDropdown<OrderController>(
          fieldTitle: 'Cajero',
          hintText: 'Seleccionar cajero',
          selectedItem: (c) => c.selectedCashier?.id,
          items: (c) => c.cashierList,
          valueSelector: (item, c) => c.cashierItems[item.id]?.id ?? '',
          displayText: (item, c) => c.userName(item),
          onChanged: (val, c) => c.onCashierSelected(val),
        ),
        SizedBox(height: 15),
        TitleTextField(
          title: 'DNI',
          hintText: 'Ingresar DNI',
          keyboardType: TextInputType.datetime,
          textController: controller.dniController,
          isNumberField: true,
        ),
        SizedBox(height: 15),
        ValueListenableBuilder<bool>(
          valueListenable: controller.isDniLoading,
          builder: (_, value, __) => Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 150,
              height: 50,
              child: value
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        backgroundColor: AppColors.textFieldBackground,
                        disabledBackgroundColor: AppColors.textFieldBackground,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: controller.onDniSearch,
                      child: Text(
                        'Rellenar datos',
                        style: TextStyleWrapper.smBold,
                      ),
                    ),
            ),
          ),
        ),
        SizedBox(height: 15),
        TitleTextField(
          title: 'Nombre del cliente',
          hintText: 'Ingresar nombre',
          textController: controller.customerNameController,
          keyboardType: TextInputType.name,
        ),
        SizedBox(height: 15),
        TitleTextField(
          title: 'Correo del cliente',
          hintText: 'Ingresar correo',
          textController: controller.emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 15),
        TitleTextField(
          title: 'Telefono del cliente',
          hintText: 'Ingresar telefono',
          textController: controller.phoneController,
          keyboardType: TextInputType.datetime,
          isNumberField: true,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
