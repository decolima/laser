import 'package:dio/dio.dart';

const baseUrl = "http://localhost:8080/bkmapp/resources";

class rest {
  static Future getRest(String path, bool auth, String token) async {
    Dio dio = Dio();
    var url = "$baseUrl$path";
    dio.options.headers['content-Type'] = 'application/json';
    if (auth) {
      dio.options.headers['Authorization'] = "Bearer $token";
    }
    try {
      var resp = await dio.get(url);
      return resp.data;
    } catch (e) {
      return e;
    }
  }

  static Future postRest(
      String path, bool auth, String token, dynamic data) async {
    Dio dio = Dio();
    var url = "$baseUrl$path";
    dio.options.headers['content-Type'] = 'application/json';
    if (auth) {
      dio.options.headers['Authorization'] = "Bearer $token";
    }
    try {
      var resp = await dio.post(url, data: data);
      return resp.data;
    } catch (e) {
      return e;
    }
  }

  static Future putRest(
      String path, bool auth, String token, dynamic data) async {
    Dio dio = Dio();
    var url = "$baseUrl$path";
    dio.options.headers['content-Type'] = 'application/json';
    if (auth) {
      dio.options.headers['Authorization'] = "Bearer $token";
    }
    try {
      var resp = await dio.put(url, data: data);
      return resp.data;
    } catch (e) {
      return e;
    }
  }

  static Future delRest(
      String path, bool auth, String token, dynamic data) async {
    Dio dio = Dio();
    var url = "$baseUrl$path";
    dio.options.headers['content-Type'] = 'application/json';
    if (auth) {
      dio.options.headers['Authorization'] = "Bearer $token";
    }
    try {
      var resp = await dio.delete(url, data: data);
      return resp.data;
    } catch (e) {
      return e;
    }
  }

  static Future patchRest(
      String path, bool auth, String token, dynamic data) async {
    Dio dio = Dio();
    var url = "$baseUrl$path";
    dio.options.headers['content-Type'] = 'application/json';
    if (auth) {
      dio.options.headers['Authorization'] = "Bearer $token";
    }
    try {
      var resp = await dio.patch(url, data: data);
      return resp.data;
    } catch (e) {
      return e;
    }
  }
}
