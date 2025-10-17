import 'package:flutter/material.dart';
import 'package:dukarmo_app/enums/user_role.dart';
import 'package:dukarmo_app/pages/home_page/home_page.dart';
import 'package:dukarmo_app/pages/main_tab_page/model/page_info.dart';
import 'package:dukarmo_app/pages/settings_page/settings_page.dart';
import 'package:dukarmo_app/pages/transaction_page/transaction_page.dart';

abstract class TabRoleConfiguration {
  UserRole get role;
  List<PageInfo> get pages;
}

class CashierTabConfiguration extends TabRoleConfiguration {
  @override
  List<PageInfo> get pages => [
    PageInfo(icon: Icons.home, title: 'Ordenes', page: HomePage()),
    PageInfo(
      icon: Icons.list_alt_sharp,
      title: 'Transacciones',
      page: TransactionPage(),
    ),
    PageInfo(
      icon: Icons.exit_to_app,
      title: 'Configuracion',
      page: SettingsPage(),
    ),
  ];

  @override
  UserRole get role => UserRole.Cashier;
}

class ManagerTabConfiguration extends TabRoleConfiguration {
  @override
  List<PageInfo> get pages => [
    PageInfo(icon: Icons.home, title: 'Ordenes', page: HomePage()),
    PageInfo(
      icon: Icons.list_alt_sharp,
      title: 'Transacciones',
      page: TransactionPage(),
    ),
    PageInfo(
      icon: Icons.exit_to_app,
      title: 'Configuracion',
      page: SettingsPage(),
    ),
  ];

  @override
  UserRole get role => UserRole.Manager;
}

class SpecialistTabConfiguration extends TabRoleConfiguration {
  @override
  List<PageInfo> get pages => [
    PageInfo(icon: Icons.home, title: 'Ordenes', page: HomePage()),
    PageInfo(
      icon: Icons.exit_to_app,
      title: 'Configuracion',
      page: SettingsPage(),
    ),
  ];

  @override
  UserRole get role => UserRole.Operator;
}
