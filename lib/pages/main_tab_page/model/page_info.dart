import 'package:flutter/material.dart';

class PageInfo {
  final IconData icon;
  final String title;
  final Widget page;
  final String? route;

  const PageInfo({
    required this.icon,
    required this.title,
    required this.page,
    this.route,
  });
}
