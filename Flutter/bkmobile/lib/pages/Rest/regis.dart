import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
class regisBkmApp extends StatefulWidget {
  void regisBkm({
    required String email,
    required String pwd,
    required String firstname,
    required String lastname,

  }) async {
    try {
      var response = await Dio().post(
          'http://192.168.0.125:8080/bkmapp/resources/users',
          data: {'first_name': firstname, 'last_name': lastname, 'email': email, 'pwd': pwd, 'roleuser': 'User'})
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