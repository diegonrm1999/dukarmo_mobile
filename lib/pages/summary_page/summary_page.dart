import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/pages/summary_page/overview_tile.dart';
import 'package:dukarmo_app/pages/summary_page/payment_tile.dart';
import 'package:dukarmo_app/pages/summary_page/stylist_list_section.dart';
import 'package:dukarmo_app/pages/summary_page/summary_controller.dart';
import 'package:dukarmo_app/widgets/status_page_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SummaryController(),
      child: Builder(
        builder: (context) {
          final controller = context.watch<SummaryController>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text("Resumen Diario", style: TextStyleWrapper.lgBold),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => controller.onClosePressed(),
                icon: Icon(Icons.close, color: Colors.black, size: 28),
              ),
            ),
            body: StatusPageContent(
              status: controller.statusPage,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTotalEarnedCard(
                      controller.dailySummary?.totalEarnings ?? 0,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: PaymentTile(
                            amount:
                                'S/${controller.dailySummary?.payments.yape ?? '0.00'}',
                            label: 'Yape',
                            icon: Icons.qr_code,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: PaymentTile(
                            amount:
                                'S/${controller.dailySummary?.payments.card ?? '0.00'}',
                            label: 'Tarjeta',
                            icon: Icons.credit_card,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: PaymentTile(
                            amount:
                                'S/${controller.dailySummary?.payments.cash ?? '0.00'}',
                            label: 'Efectivo',
                            icon: Icons.money,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Informe de Operaciones',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    OverviewTile(
                      title: 'Numero de Ordenes',
                      value: '${controller.dailySummary?.totalOrders ?? '0'}',
                    ),
                    if (controller.dailySummary != null &&
                        controller
                            .dailySummary!
                            .ordersByStylist
                            .isNotEmpty) ...[
                      SizedBox(height: 12),
                      StylistListSection(
                        stylists: controller.dailySummary!.ordersByStylist,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTotalEarnedCard(double amount) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE6F0),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ganancia total', style: TextStyleWrapper.mdGreyMedium),
          SizedBox(height: 3),
          Text('S/. $amount', style: TextStyleWrapper.xxlBold),
        ],
      ),
    );
  }
}
