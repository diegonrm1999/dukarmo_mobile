import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/widgets/status_page_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/enums/payment_method.dart';
import 'package:dukarmo_app/pages/checkout_page/checkout_controller.dart';
import 'package:dukarmo_app/widgets/buttons/loading_context_button.dart';
import 'package:dukarmo_app/widgets/selectors/payment_selector.dart';
import 'package:dukarmo_app/widgets/textfields/title_text_field.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  final GoRouterState? state;
  const CheckoutPage({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckoutController(state: state),
      child: Builder(
        builder: (context) {
          final controller = context.read<CheckoutController>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                controller.titleMessage,
                style: TextStyleWrapper.lgBold,
              ),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: controller.onBackPressed,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 40,
              ),
              child: ValueListenableBuilder<StatusPage>(
                valueListenable: controller.statusPage,
                builder: (_, status, __) => StatusPageContent(
                  status: status,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildFormBody(controller),
                        SizedBox(
                          width: double.infinity,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: controller.isSubmitLoading,
                            builder: (_, isLoading, __) => SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: LoadingContextButton(
                                text: "Completar Orden",
                                isLoading: isLoading,
                                onPressed: controller.onSubmitOrder,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildFormBody(CheckoutController controller) {
    return Consumer<CheckoutController>(
      builder: (_, controller, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resumen', style: TextStyleWrapper.lgBold),
            SizedBox(height: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Servicio', style: TextStyleWrapper.mdRegular),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      ...controller.treatmentList.map(
                        (entry) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.treatment.name,
                              style: TextStyleWrapper.smRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 25),
                            Text(
                              'S/ ${entry.price.toStringAsFixed(2)}',
                              style: TextStyleWrapper.smRegular.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),
            Text('Detalles', style: TextStyleWrapper.lgBold),
            SizedBox(height: 20),
            Text(
              'Cliente: ${controller.currentOrder?.client.name ?? ""}',
              style: TextStyleWrapper.mdRegular,
            ),
            SizedBox(height: 30),
            Text('Pago', style: TextStyleWrapper.lgBold),
            SizedBox(height: 20),
            ValueListenableBuilder<PaymentMethod>(
              valueListenable: controller.selectedPaymentMethod,
              builder: (_, value, __) => PaymentMethodSelector(
                selectedMethod: value,
                onTap: controller.onPaymentMethodSelected,
                methods: PaymentMethod.values,
              ),
            ),
            SizedBox(height: 7),
            TitleTextField(
              title: 'Numero de ticket',
              hintText: 'Ingrese el numero de ticket',
              textController: controller.numberTicketController,
            ),
            SizedBox(height: 25),
          ],
        );
      },
    );
  }
}
