import 'package:logger/logger.dart';

Logger getLogger<T>() {
  T.toString();
  return Logger(
    printer: PrettyPrinter(
      colors: false,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );
}
