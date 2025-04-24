import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionInternet {
  static Future<bool?> isInternet() async {
    bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected) {
      return true;
    } else {
      return false;
    }
  }
}
