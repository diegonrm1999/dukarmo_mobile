import 'package:flutter/material.dart';
import 'package:dukarmo_app/pages/main_tab_page/configurations/tab_role_configuration.dart';

class MainTabController extends ChangeNotifier {
  int currentIndex = 0;
  bool _isDisposed = false;

  final TabRoleConfiguration config;

  MainTabController({required this.config});

  void setCurrentIndex(int index) => currentIndex = index;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> onBottomNavigationBarTap(int index) async {
    setCurrentIndex(index);
    if (_isDisposed) return;
    notifyListeners();
  }
}
