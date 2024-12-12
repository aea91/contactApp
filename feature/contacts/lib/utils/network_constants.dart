class NetworkConstants {
  static const String user = "/api/User";
  static String deleteUser({required String id}) => "/api/User/$id";
  static String updateUser({required String id}) => "/api/User/$id";
  static const String uploadImage = "/api/User/uploadImage";
}
