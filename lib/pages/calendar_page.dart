import 'package:dukarmo_app/domain/list_item/order_list_item.dart';
import 'package:flutter/material.dart';
import 'package:dukarmo_app/core/theme/color/colors.dart';
import 'package:dukarmo_app/core/theme/wrapper/text_style_wrapper.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/pages/calendar_page/calendar_controller.dart';
import 'package:dukarmo_app/widgets/order_list/order_list.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<CalendarController>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            flex: 55,
            child: Container(
              padding: EdgeInsets.only(left: 30, right: 20),
              child: Selector<CalendarController, DateTime>(
                selector: (_, controller) => controller.selectedDate,
                builder: (_, selectedDate, __) => TableCalendar(
                  rowHeight: 45,
                  focusedDay: controller.selectedDate,
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) =>
                      controller.onDaySelected(selectedDay, focusedDay),
                  calendarFormat: CalendarFormat.month,
                  availableCalendarFormats: const {CalendarFormat.month: ''},
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primaryButton,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: Text('Citas', style: TextStyleWrapper.xlBold),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child:
                      Selector<
                        CalendarController,
                        ({List<OrderListItem> orders, StatusPage statusPage})
                      >(
                        selector: (_, controller) => (
                          orders: controller.orders,
                          statusPage: controller.statusPage,
                        ),
                        builder: (_, selectedDate, __) {
                          return OrderList(
                            onRefresh: controller.onRefresh,
                            orders: controller.orders,
                            status: controller.statusPage,
                          );
                        },
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
