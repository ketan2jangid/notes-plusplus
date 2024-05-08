import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isConnected() async {
  final connection = await Connectivity().checkConnectivity();

  if (connection.contains(ConnectivityResult.mobile) ||
      connection.contains(ConnectivityResult.wifi)) return true;
  return false;
}
