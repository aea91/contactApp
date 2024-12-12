import 'package:core/exception/app_exception.dart';
import 'package:equatable/equatable.dart';

class GlobalState extends Equatable {
  const GlobalState({required this.exception, required this.contactList, required this.isRefresh});

  final AppException? exception;
  final List<dynamic> contactList;
  final bool isRefresh;

  factory GlobalState.initial() {
    return const GlobalState(exception: null, contactList: [], isRefresh: false);
  }

  GlobalState copyWith({AppException? exception, List<dynamic>? contactList, bool? isRefresh}) {
    return GlobalState(
        exception: exception ?? this.exception,
        contactList: contactList ?? this.contactList,
        isRefresh: isRefresh ?? this.isRefresh);
  }

  @override
  List<Object?> get props => [exception, contactList, isRefresh];
}
