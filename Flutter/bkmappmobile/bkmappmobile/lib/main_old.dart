import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'App.dart';

void main_old() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}