import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/constants/constants.dart';

class ServerConnectivity {
  static final ServerConnectivity _instance = ServerConnectivity._init();
  factory ServerConnectivity() => _instance;
  ServerConnectivity._init();
  static final Dio dio = Dio();
  Logger logger = Logger();

  void startPeriodicCheck() {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      await checkServerConnectivity();
    });
  }

  Future<bool> checkServerConnectivity() async {
    try {
      var response = await dio
          .get('${Constants.serverIpAdress}/pets')
          .timeout(const Duration(seconds: 2));

      if (response.statusCode == 200) {
        logger.log(Level.info, "Server connectivty established");
        return true;
      }
    } catch (_) {
      logger.log(Level.info, "Server not reachable");
    }

    return false;
  }
}
