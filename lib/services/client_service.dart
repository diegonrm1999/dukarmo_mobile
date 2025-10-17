import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/dto/client_dto.dart';
import 'package:dukarmo_app/managers/client_manager.dart';

class ClientService {
  final _clientManager = getSingleton<ClientManager>();

  Future<ClientDto> getClientByDni(String dni) async {
    return _clientManager.getClientByDni(dni);
  }
}
