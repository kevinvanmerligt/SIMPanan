import 'package:intl/intl.dart';

class DateFormatId {
  static String formatHariTanggal(DateTime date) {
    // Menghasilkan format seperti: Rabu, 4 Juni
    return DateFormat('EEEE, d MMMM', 'id_ID').format(date);
  }
}