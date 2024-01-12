import 'package:intl/intl.dart';

String dateTimeFromMillisecond(int dateTimeInMillis, {String pattern = "dd MMM yyyy"}){
  DateTime dt = DateTime.fromMillisecondsSinceEpoch(dateTimeInMillis);
  return DateFormat(pattern).format(dt);
}