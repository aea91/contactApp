// ignore_for_file: non_constant_identifier_names

abstract class IContactLogger {
  info(String TAG, String Message);
  error(String TAG, String Message);
  warning(String TAG, String Message);
}
