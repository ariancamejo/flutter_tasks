import 'package:my_tasks/data/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_tasks/presentation/router/go_router.dart';

class Utils {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  //configuracion del cliente http
  static RestClient http = RestClient(DioHttpHelper.client());

  //acceso al contexto actual proporcionado por goRouter
  static BuildContext? currentContext() => GoNavigator.router.routeInformationParser.configuration.navigatorKey.currentContext;
}