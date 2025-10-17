import 'package:dukarmo_app/api/treatment_api.dart';
import 'package:dukarmo_app/domain/treatment.dart';
import 'package:dukarmo_app/managers/common/base_manager.dart';

class TreatmentManager extends BaseManager<TreatmentApi> {
  TreatmentManager({mockedApi});

  Future<List<Treatment>> getTreatments() async {
    final response = await api.getTreatments();

    if (response.error == null) {
      return (response.data as List)
          .map((treatment) => Treatment.fromJsonModel(treatment))
          .toList();
    } else {
      throw Exception('Failed to load treatments');
    }
  }
}
