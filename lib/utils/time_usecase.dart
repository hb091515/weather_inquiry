import 'package:intl/intl.dart';

class TimeUsecase {
  static String conventDateTime(String time) {
    DateTime dateTime = DateTime.parse(time);

    String formattedDateTime = DateFormat('M/d H時').format(dateTime);

    return formattedDateTime;
  }
}
