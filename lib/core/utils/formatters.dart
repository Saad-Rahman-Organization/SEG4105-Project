import 'package:intl/intl.dart';

class NutriFormatters {
  static final DateFormat _day = DateFormat('MMM d');
  static final DateFormat _time = DateFormat('h:mm a');

  static String shortDay(DateTime dateTime) => _day.format(dateTime);

  static String time(DateTime dateTime) => _time.format(dateTime);

  static String calories(int calories) => '$calories kcal';
}
