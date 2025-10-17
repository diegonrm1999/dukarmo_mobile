import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Middleware {
  Future<String?> redirect(BuildContext context, GoRouterState state);
}
