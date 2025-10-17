import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:dukarmo_app/routes/app_pages/app_pages.dart';

class NavigationService {
  final GoRouter _router = AppPages.pages;
  String? _previousRoute;

  String get _fallbackPreviousRoute => _previousRoute ?? _location;
  String get _currentRoute => _location;

  String getCurrentRoute() => _currentRoute;

  final Map<String, Completer<dynamic>> _routeCompleters = {};

  String get _location {
    try {
      return _router.state.uri.toString();
    } catch (e) {
      return '/';
    }
  }

  BuildContext get context {
    final context = _router.routerDelegate.navigatorKey.currentContext;
    if (context == null) {
      const String error = "Context is not set";
      throw StateError(error);
    }
    return context;
  }

  void completeRoute(String routeName, [dynamic result]) {
    if (_routeCompleters.containsKey(routeName)) {
      try {
        _routeCompleters[routeName]?.complete(result);
      } catch (error) {
        print('Error completing route $routeName: $error');
      } finally {
        _routeCompleters.remove(routeName);
      }
    }
  }

  Future<T?> toNamed<T>(String routeName, {dynamic extra}) async {
    if (routeName == _currentRoute) {
      return null;
    }
    final T? result = await _router.push(routeName, extra: extra);
    _updatePreviousRoute();
    return result;
  }

  Future<T?> to<T>(
    String routeName, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
    dynamic extra,
  }) async {
    if (routeName == _currentRoute) {
      return null;
    }
    final T? result = await _router.pushNamed(
      routeName,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
    _updatePreviousRoute();
    return result;
  }

  Future<T?> offNamed<T>(String routeName, {dynamic extra}) async {
    if (routeName == _currentRoute) {
      return null;
    }
    final T? result = await _router.pushReplacement(routeName, extra: extra);
    _updatePreviousRoute(previousRoute: _previousRoute);
    completeRoute(_fallbackPreviousRoute);
    return result;
  }

  void offAllNamed<T>(String routeName, {dynamic extra}) async {
    if (routeName == _currentRoute) {
      return null;
    }
    _router.go(routeName, extra: extra);
    _updatePreviousRoute(previousRoute: _previousRoute);
  }

  Future<T?> offAllNamedWithResult<T>(String routeName, {dynamic extra}) async {
    if (routeName == _currentRoute) {
      return null;
    }
    final completer = Completer<T?>();
    _routeCompleters[routeName] = completer;

    _router.go(routeName, extra: extra);
    _updatePreviousRoute(previousRoute: _previousRoute);

    return completer.future;
  }

  void offAndToNamed(String routeName, {dynamic extra}) async {
    if (routeName == _currentRoute) {
      return null;
    }
    await _router.pushReplacement(routeName, extra: extra);
    _updatePreviousRoute();
    completeRoute(_fallbackPreviousRoute);
  }

  Map<String, String> get parameters {
    return _router.state.pathParameters;
  }

  Map<String, String> get queryParameters {
    return _router.state.pathParameters;
  }

  dynamic get extra {
    return _router.state.extra;
  }

  void until(bool Function(Route) predicate) {
    Navigator.of(context).popUntil(predicate);
  }

  void closeOverlays() {
    until((route) => route.settings.name != null);
  }

  void back({dynamic result}) {
    if (_router.canPop()) {
      _router.pop(result);
      if (!isDialogOpen) {
        _updatePreviousRoute(previousRoute: _previousRoute);
      }
    }
  }

  void _updatePreviousRoute({String? previousRoute}) {
    _previousRoute = previousRoute ?? _currentRoute;
  }

  /// Only for internal middleware usage
  /// Do not use this out of BaseMiddleware.
  void updatePreviousRouteForMiddleware() {
    _previousRoute = _currentRoute;
  }

  bool get isDialogOpen {
    return _hasPopupRoute() ?? false;
  }

  bool get isDialog {
    return _hasPopupRoute(checkIsCurrent: true) ?? false;
  }

  bool? _hasPopupRoute({bool checkIsCurrent = false}) {
    final modalRoute = ModalRoute.of(context);

    if (modalRoute is PopupRoute) {
      return checkIsCurrent ? modalRoute.isCurrent : true;
    }

    return null;
  }

  bool isCurrentUniqueRoute() {
    final navigator = Navigator.of(context);
    final modalRoute = ModalRoute.of(context);

    return !navigator.canPop() && modalRoute?.isCurrent == true;
  }

  bool checkCurrentRouteContains(String pattern) {
    return _currentRoute.contains(pattern);
  }

  bool checkPreviousRouteContains(String pattern) {
    return _fallbackPreviousRoute.contains(pattern);
  }

  bool isCurrentRoute(String routeName) {
    return _currentRoute == routeName;
  }

  bool isPreviousRoute(String routeName) {
    return _fallbackPreviousRoute == routeName;
  }
}
