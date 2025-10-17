import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/pages/order_page/order_content.dart';
import 'package:dukarmo_app/pages/order_page/order_controller.dart';
import 'package:dukarmo_app/widgets/buttons/loading_context_button.dart';
import 'package:dukarmo_app/widgets/status_page_content.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatelessWidget {
  final GoRouterState? state;
  const OrderPage({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderController(state: state),
      child: Builder(
        builder: (context) {
          final controller = context.read<OrderController>();
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
                        OrderContent(controller: controller),
                        SizedBox(
                          width: double.infinity,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: controller.isSubmitLoading,
                            builder: (_, isLoading, __) => SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: LoadingContextButton(
                                text: controller.buttonMessage,
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
}
