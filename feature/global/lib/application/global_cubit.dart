import 'package:core/exception/app_exception.dart';
import 'package:core/exception/exception_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global/application/global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalState.initial());

  void setException(AppException exception) {
    print('exception geldi: ${exception.message}');
    emit(state.copyWith(exception: exception));
  }

  void clearException() {
    emit(state.copyWith(
        exception: AppException(message: '', type: ExceptionType.info, showMessage: false)));
  }

  void setContactList(List<dynamic> contactList) {
    emit(state.copyWith(contactList: contactList));
  }

  void clearContactList() {
    emit(state.copyWith(contactList: []));
  }

  void setIsRefresh(bool val) {
    emit(state.copyWith(isRefresh: val));
  }
}
