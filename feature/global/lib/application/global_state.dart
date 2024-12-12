import 'package:core/exception/app_exception.dart';
import 'package:equatable/equatable.dart';

class GlobalState extends Equatable {
  const GlobalState({required this.exception, required this.contactList});

  final AppException? exception;
  final List<dynamic> contactList;

  factory GlobalState.initial() {
    return const GlobalState(exception: null, contactList: []);
  }

  GlobalState copyWith({AppException? exception, List<dynamic>? contactList}) {
    return GlobalState(
      exception: exception ?? this.exception,
      contactList: contactList ?? this.contactList,
    );
  }

  @override
  List<Object?> get props => [exception, contactList];
}
