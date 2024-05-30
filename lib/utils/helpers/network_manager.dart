import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:outfit4rent/common/widgets/loaders/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  // Initial the network manager
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((results) {
      for (var result in results) {
        _updateConnectionStatus(result);
      }
    });
  }

  // Update the connection status
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      TLoaders.warningSnackBar(title: "No Internet Connection");
    }
  }

  // Check the internet connection
  // return true if connected
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // Dispose the network manager
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
