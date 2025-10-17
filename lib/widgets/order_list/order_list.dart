import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/widgets/order_item.dart';
import 'package:dukarmo_app/widgets/status_page_content.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    super.key,
    required this.orders,
    required this.status,
    required this.onRefresh,
    this.onItemTap,
    this.backgroundColor = AppColors.primaryButton,
    this.showTransactionModal = false,
  });
  final List<OrderListItem> orders;
  final bool showTransactionModal;
  final StatusPage status;
  final Function(int)? onItemTap;
  final Future<void> Function() onRefresh;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StatusPageContent(
            status: status,
            onRefresh: onRefresh,
            child: RefreshIndicator(
              onRefresh: onRefresh,
              color: Colors.black,
              backgroundColor: Colors.white,
              displacement: 40,
              strokeWidth: 2.5,
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, index) {
                  return OrderItem(
                  backgroundColor: backgroundColor,
                    orderNumber: orders[index].orderNumber.toString(),
                    clientName: orders[index].client.name,
                    onItemTap: onItemTap != null
                        ? () => onItemTap!(index)
                        : null,
                    operatorName: orders[index].stylist.name,
                    totalPrice: orders[index].totalPrice,
                    date: orders[index].createdAt,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
