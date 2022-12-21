import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'network_helper.dart';

class NetworkHelperImpl implements NetworkHelper {
  NetworkHelperImpl({
    required this.connectionChecker,
  });
  final InternetConnectionChecker connectionChecker;
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
