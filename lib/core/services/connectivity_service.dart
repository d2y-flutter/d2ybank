import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectivityService {
  Future<bool> get isConnected;
  Stream<bool> get onConnectivityChanged;
}

class ConnectivityServiceImpl implements ConnectivityService {
  final InternetConnectionChecker _checker;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();

  ConnectivityServiceImpl({InternetConnectionChecker? checker})
      : _checker = checker ?? InternetConnectionChecker.instance {
    _checker.onStatusChange.listen((status) {
      _controller.add(status == InternetConnectionStatus.connected);
    });
  }

  @override
  Future<bool> get isConnected => _checker.hasConnection;
  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;
}
