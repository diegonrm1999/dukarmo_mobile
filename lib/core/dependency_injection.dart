import 'package:dukarmo_app/event_bus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dukarmo_app/api/client_api.dart';
import 'package:dukarmo_app/api/common/http.dart';
import 'package:dukarmo_app/api/login_api.dart';
import 'package:dukarmo_app/api/order_api.dart';
import 'package:dukarmo_app/api/treatment_api.dart';
import 'package:dukarmo_app/api/user_api.dart';
import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/storage_preferences.dart';
import 'package:dukarmo_app/managers/client_manager.dart';
import 'package:dukarmo_app/managers/login_manager.dart';
import 'package:dukarmo_app/managers/order_manager.dart';
import 'package:dukarmo_app/managers/treatment_manager.dart';
import 'package:dukarmo_app/managers/user_manager.dart';
import 'package:dukarmo_app/services/auth_service.dart';
import 'package:dukarmo_app/services/client_service.dart';
import 'package:dukarmo_app/services/navigation_service.dart';
import 'package:dukarmo_app/services/session_service.dart';
import 'package:dukarmo_app/services/order_service.dart';
import 'package:dukarmo_app/services/socket_service.dart';
import 'package:dukarmo_app/services/treatment_service.dart';
import 'package:dukarmo_app/services/user_service.dart';
import 'package:dukarmo_app/widgets/snackbar.dart';

class DependencyInjection {
  static Future<void> init() async {
    final prefs = FlutterSecureStorage();
    registerLazySingleton<SocketService>(() => SocketService());
    registerLazySingleton<OrderEventBus>(() => OrderEventBus());
    getSingleton<SocketService>().init();
    registerSingleton(StoragePreferences(prefs));
    registerApis();
    registerManagers();
    await registerServices();
    registerSingleton<Snackbar>(Snackbar());
  }

  static void registerApis() {
    registerLazySingleton<Http>(() => Http());
    registerLazySingleton<LoginApi>(() => LoginApi());
    registerLazySingleton<OrderApi>(() => OrderApi());
    registerLazySingleton<TreatmentApi>(() => TreatmentApi());
    registerLazySingleton<UserApi>(() => UserApi());
    registerLazySingleton<ClientApi>(() => ClientApi());
  }

  static void registerManagers() {
    registerLazySingleton<OrderManager>(() => OrderManager());
    registerLazySingleton<LoginManager>(() => LoginManager());
    registerLazySingleton<TreatmentManager>(() => TreatmentManager());
    registerLazySingleton<UserManager>(() => UserManager());
    registerLazySingleton<ClientManager>(() => ClientManager());
  }

  static Future<void> registerServices() async {
    registerLazySingleton<NavigationService>(() => NavigationService());
    registerLazySingleton<SessionService>(() => SessionService());
    registerLazySingleton<OrderService>(() => OrderService());
    registerLazySingleton<UserService>(() => UserService());
    registerLazySingleton<TreatmentService>(() => TreatmentService());
    registerLazySingleton<AuthService>(() => AuthService());
    registerLazySingleton<ClientService>(() => ClientService());
    final authService = getSingleton<SessionService>();
    await authService.bootstrapSessionFromStorage();
  }
}
