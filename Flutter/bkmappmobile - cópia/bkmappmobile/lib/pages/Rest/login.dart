import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class loginBkmApp extends StatefulWidget {
  void loginBkm({
  required String user,
    required String pwd,
}) async {
    print(user);
    try {
      var response = await Dio().post(
          'http://192.168.0.125:8080/bkmapp/resources/users/login',
          data: {'usr': user, 'pwd': pwd})
      .then((ris) {
          print(ris.data);
          print("test response ok");
      });
    } catch (e) {
      print("test response nok");
      print(e);
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}