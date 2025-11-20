import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';

class ConnectivityController extends StateNotifier<bool> {
  ConnectivityController(this._connectivity) : super(false) {
    _subscription = _connectivity.onConnectivityChanged.listen(_handleStatus);
    _connectivity.checkConnectivity().then(_handleStatus);
  }

  final Connectivity _connectivity;
  StreamSubscription<dynamic>? _subscription;

  void _handleStatus(dynamic result) {
    if (result is List<ConnectivityResult>) {
      state = result.every((entry) => entry == ConnectivityResult.none);
    } else if (result is ConnectivityResult) {
      state = result == ConnectivityResult.none;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final connectivityProvider =
    StateNotifierProvider<ConnectivityController, bool>((ref) {
  return ConnectivityController(Connectivity());
});
