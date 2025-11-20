import 'package:intl/intl.dart';

class NutriFormatters {
  static final DateFormat _day = DateFormat('MMM d');
  static final DateFormat _time = DateFormat('h:mm a');

  static String shortDay(DateTime dateTime) => _day.format(dateTime);

  static String time(DateTime dateTime) => _time.format(dateTime);

  static String calories(int calories) => '$calories kcal';

  static String grams(num grams) {
    final base = grams % 1 == 0 ? grams.toInt().toString() : grams.toStringAsFixed(1);
    return '$base g';
  }

  static String gramsShort(num grams) {
    final base = grams % 1 == 0 ? grams.toInt().toString() : grams.toStringAsFixed(1);
    return '${base}g';
  }
}
