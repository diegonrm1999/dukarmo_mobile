import 'package:dukarmo_app/domain/order.dart';
import 'package:dukarmo_app/pages/order_detail_page/order_detail_page.dart';
import 'package:dukarmo_app/pages/summary_page/summary_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/pages/checkout_page/checkout_page.dart';
import 'package:dukarmo_app/pages/home_page/middleware/home_page_middleware.dart';
import 'package:dukarmo_app/pages/login_page/login_page.dart';
import 'package:dukarmo_app/pages/main_page.dart/main_page.dart';
import 'package:dukarmo_app/pages/order_page/order_page.dart';
import 'package:dukarmo_app/routes/app_routes/app_routes.dart';
class AppPages {
  static GoRouter pages = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      _buildRoute(path: AppRoutes.login, child: const LoginPage()),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) {
          return _buildPage(state: state, child: const MainPage());
        },
        redirect: HomePageMiddleware().redirect,
      ),
      _buildRoute(path: AppRoutes.newOrder, child: const OrderPage()),
      GoRoute(
        path: AppRoutes.orderDetail,
        pageBuilder: (context, state) {
          return _buildPage(
            state: state,
            child: OrderPage(state: state),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.orderCheckout,
        pageBuilder: (context, state) {
          return _buildPage(
            state: state,
            child: CheckoutPage(state: state),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.complete,
        pageBuilder: (context, state) {
          final order = state.extra as Order;
          return _buildPage(
            state: state,
            child: OrderDetailPage(order: order),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.summary,
        pageBuilder: (context, state) {
          return _buildPage(
            state: state,
            child: SummaryPage(),
          );
        },
      ),
    ],
  );

  static GoRoute _buildRoute({required String path, required Widget child}) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => _buildPage(state: state, child: child),
    );
  }

  static CustomTransitionPage _buildPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.97, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
