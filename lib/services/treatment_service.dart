import 'package:dukarmo_app/core/locator.dart';
import 'package:dukarmo_app/domain/treatment.dart';
import 'package:dukarmo_app/managers/treatment_manager.dart';

class TreatmentService {
  final _treatmentManager = getSingleton<TreatmentManager>();

  Future<List<Treatment>> getTreatments() async {
    try {
      return await _treatmentManager.getTreatments();
    } catch (e) {
      throw Exception('Error fetching treatments: $e');
    }
  }
}
