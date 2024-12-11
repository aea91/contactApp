import 'package:core/exception/app_exception.dart';

class NetworkException extends AppException {
  const NetworkException(
      {super.message, super.showMessage, required this.type, required this.statusCode});

  final String type;
  final int statusCode;

  NetworkException.fromException(NetworkException exception)
      : this(message: exception.message, type: exception.type, statusCode: exception.statusCode);
}
