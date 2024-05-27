import 'package:logger/logger.dart';

class LogMessage {
  final String message;
  final logger = Logger();
  LogMessage(this.message) {
    logger.i(message);
  }
}
