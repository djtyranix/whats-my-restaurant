import 'package:intl/intl.dart';

class DateTimeHelper {
  static DateTime getNotificationShowTime() {
    // Date and Time Format
   final now = DateTime.now();
   final dateFormat = DateFormat('y/M/d');
   const timeSpecific = "11:00:00"; // TODO: Make it changeable
   final completeFormat = DateFormat('y/M/d H:m:s');
 
   // Today Format
   final todayDate = dateFormat.format(now);
   final todayDateAndTime = "$todayDate $timeSpecific";
   var resultToday = completeFormat.parseStrict(todayDateAndTime);
 
   // Tomorrow Format
   var formatted = resultToday.add(const Duration(days: 1));
   final tomorrowDate = dateFormat.format(formatted);
   final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
   var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);
 
   return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}