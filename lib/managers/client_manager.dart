import 'package:dukarmo_app/api/client_api.dart';
import 'package:dukarmo_app/domain/dto/client_dto.dart';
import 'package:dukarmo_app/managers/common/base_manager.dart';

class ClientManager extends BaseManager<ClientApi> {
  ClientManager({mockedApi});

  Future<ClientDto> getClientByDni(String dni) async {
    final result = await api.getClientByDni(dni);
    if (result.error == null) {
      return ClientDto.fromJson(result.data);
    } else {
      throw Exception(result.error);
    }
  }
}
