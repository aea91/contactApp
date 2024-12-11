import 'package:equatable/equatable.dart';

class AppException extends Equatable implements Exception {
  const AppException({
    this.message,
    this.showMessage = true,
  });

  final String? message;
  final bool? showMessage;

  @override
  List<Object?> get props => [message, showMessage];
}
