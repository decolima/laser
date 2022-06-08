import 'package:backendrest/control/UserStore.dart';
import 'package:backendrest/pages/login.dart';
import 'package:flutter/material.dart';
import 'control/ListUtenti.dart';
import 'entity/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoListUtenti(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text("Nome do Usuario"),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Test Laser',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WidgetLogin());
  }
}

class rowlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DoListUtenti(),
    );
  }
}
