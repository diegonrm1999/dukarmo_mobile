import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/user.dart';
import 'package:dukarmo_app/managers/user_manager.dart';

class UserService {
  final _userManager = getSingleton<UserManager>();

  Future<List<User>> getAllCashiers() async {
    final users = await _userManager.fetchCashiers();
    return users;
  }

  Future<List<User>> getAllStylists() async {
    final users = await _userManager.fetchStylist();
    return users;
  }
}
