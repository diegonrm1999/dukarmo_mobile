import 'package:dukarmo_app/api/user_api.dart';
import 'package:dukarmo_app/domain/user.dart';
import 'package:dukarmo_app/managers/common/base_manager.dart';

class UserManager extends BaseManager<UserApi> {
  UserManager({mockedApi});

  Future<List<User>> fetchCashiers() async {
    try {
      final response = await api.getCashiers();
      if (response.error == null) {
        return (response.data as List)
            .map((user) => User.fromJson(user))
            .toList();
      } else {
        throw Exception('Error al cargar cajeros');
      }
    } catch (e) {
      throw Exception('Error al cargar cajeros');
    }
  }

  Future<List<User>> fetchStylist() async {
    try {
      final response = await api.getStylist();
      if (response.error == null) {
        return (response.data as List)
            .map((user) => User.fromJson(user))
            .toList();
      } else {
        throw Exception('Error al cargar cajeros');
      }
    } catch (e) {
      throw Exception('Error al cargar cajeros');
    }
  }
}
