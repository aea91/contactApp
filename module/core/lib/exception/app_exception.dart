import 'package:core/exception/exception_type.dart';
import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  const AppException({
    this.message,
    this.showMessage = true,
    this.type,
  });

  final String? message;
  final bool? showMessage;
  final ExceptionType? type;
  @override
  List<Object?> get props => [message, showMessage, type];
}
