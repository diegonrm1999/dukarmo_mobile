import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/daily_summary.dart';
import 'package:dukarmo_app/enums/status_page.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class SummaryController extends ChangeNotifier {
  final _navigationService = getSingleton<NavigationService>();
  final _orderService = getSingleton<OrderService>();
  final _snackbar = getSingleton<Snackbar>();

  bool _isDisposed = false;
  DailySummary? dailySummary;
  StatusPage statusPage = StatusPage.loading;

  SummaryController() {
    _onInit();
  }

  Future<void> _onInit() async {
    try {
      await _fetchSummaryData();
      statusPage = StatusPage.success;
    } catch (e) {
      statusPage = StatusPage.error;
      _snackbar.show("Error al cargar los datos");
    } finally {
      if (!_isDisposed) {
        notifyListeners();
      }
    }
  }

  Future<void> _fetchSummaryData() async {
    dailySummary = await _orderService.fetchDailySummary();
    notifyListeners();
  }

  Future<void> onClosePressed() async {
    _navigationService.offAllNamed(AppRoutes.home);
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
