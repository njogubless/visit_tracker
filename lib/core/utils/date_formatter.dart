import 'package:intl/intl.dart';

class DateFormatter {
  static final DateFormat _displayFormat = DateFormat('MMM dd, yyyy HH:mm');
  static final DateFormat _isoFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
  
  static String formatForDisplay(DateTime date) {
    return _displayFormat.format(date);
  }
  
  static String formatForApi(DateTime date) {
    return date.toIso8601String();
  }
  
  static DateTime parseFromApi(String dateString) {
    return DateTime.parse(dateString);
  }
}