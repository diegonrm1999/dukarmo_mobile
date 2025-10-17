import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
import 'package:dukarmo_app/services/navigation_service.dart';

class CompleteOrderController {
  final _navigationService = getSingleton<NavigationService>();

  void onBackPressed() {
    _navigationService.offAllNamed(AppRoutes.home);
  }
}
