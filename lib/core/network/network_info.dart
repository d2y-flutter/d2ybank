import '../services/connectivity_service.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final ConnectivityService _connectivity;
  NetworkInfoImpl(this._connectivity);
  @override
  Future<bool> get isConnected => _connectivity.isConnected;
}
