import 'package:intl/intl.dart';

class DateTimeUtil {
  static String formatBasedOnTodayOrYesterday(DateTime dateTime) {
    final now = DateTime.now();
    final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToCheck == DateTime(now.year, now.month, now.day)) {
      // If date is today, show time
      return DateFormat("H:mm").format(dateTime);
    } else {
      // If date is yesterday or earlier, show Month day
      return DateFormat("MMM d").format(dateTime);
    }
  }
}
