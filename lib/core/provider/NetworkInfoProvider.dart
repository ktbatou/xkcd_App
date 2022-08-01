import 'package:flutter/foundation.dart';
import 'package:xkcd_app/core/network/network_info.dart';

class NetworkInfoProvider extends ChangeNotifier {
  bool _isConnected = true;
  final NetworkInfo networkInfo;
  NetworkInfoProvider({required this.networkInfo});

  get isConnected => _isConnected;
  checkNetwork() async {
    if (await networkInfo.isConnected) {
      _isConnected = true;
    } else {
      _isConnected = false;
    }

    notifyListeners();
  }

  setNetworkAvailability(bool hasConnection) {
    _isConnected = hasConnection;
    notifyListeners();
  }
}
