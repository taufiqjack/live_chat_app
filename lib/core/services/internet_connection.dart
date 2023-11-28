import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/foundation.dart';

class InternetConnection {
  static Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        if (kDebugMode) {
          print("Jaringan Data terkoneksi & koneksi internet terkonfirmasi.");
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Tidak ada Jaringan Internet :(');
        }
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        if (kDebugMode) {
          print("Jaringan WIFI terkoneksi & koneksi internet terkonfirmasi");
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Tidak ada Jaringan Internet :(');
        }
        return false;
      }
    } else {
      if (kDebugMode) {
        print(
            "Jaringan Data dan WIFI tidak terdeteksi, jaringan internet tidak ditemukan.");
      }
      return false;
    }
  }
}
