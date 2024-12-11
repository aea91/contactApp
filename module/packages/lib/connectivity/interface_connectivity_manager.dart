import 'package:packages/connectivity/connectivity_result.dart';

abstract class IConnectivityManager {
  Future<NetworkResult> checkNetwork();
  void handleNetworkChange(void Function(NetworkResult result) onChanged);
  void dispose();
}
