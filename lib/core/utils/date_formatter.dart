import 'package:intl/intl.dart';

class DateFormatter {
  static String formatShort(String isoDate) {
    try {
      final date = DateTime.parse(isoDate).toLocal();
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return '';
    }
  }

  static String formatLong(String isoDate) {
    try {
      final date = DateTime.parse(isoDate).toLocal();
      return DateFormat("d 'de' MMMM 'de' yyyy", 'es_ES').format(date);
    } catch (_) {
      return '';
    }
  }

  static String formatWithTime(String isoDate) {
    try {
      final date = DateTime.parse(isoDate).toLocal();
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (_) {
      return '';
    }
  }
}