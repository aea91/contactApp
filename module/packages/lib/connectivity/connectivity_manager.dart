import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:packages/connectivity/connectivity_result.dart';
import 'package:packages/connectivity/interface_connectivity_manager.dart';

typedef NetworkCallBack = void Function(NetworkResult result);

class ConnectivityManager extends IConnectivityManager {
  late final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;

  ConnectivityManager() {
    _connectivity = Connectivity();
  }
  @override
  Future<NetworkResult> checkNetwork() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return NetworkResult.checkConnectivity(connectivityResult);
  }

  @override
  void handleNetworkChange(NetworkCallBack onChanged) {
    _subscription = _connectivity.onConnectivityChanged.listen((event) {
      onChanged.call(NetworkResult.checkConnectivity(event));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
  }
}
