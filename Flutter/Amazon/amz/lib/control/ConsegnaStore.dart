import '../entity/Consegna.dart';
import '../entity/User.dart';
import '../service/rest.dart';
import 'AppControl.dart';

class ConsegnaStore {
  static Future getConsegna(User usr, int page, int size) async {
    var cnsg = <Consegna>[];
    var resp = [];

    //print(usr.firstName);

    try {
      resp = await rest.getRest("/consegna/do", true, usr.token!, page, size);
      for (var a in resp) {
        //print(a);
        cnsg.add(Consegna.fromJson(a));
      }

      for (var b in cnsg) {
        print("Add..${b.indirizzo}");
        AppControl.addConsegna(b);
      }
      return (true);
    } catch (e) {
      print(e);
      return Consegna(error: e.toString());
    }
  }
/*
  static Future getSingleConsegna(User usr, String id) async {
    late Consegna cnsg;

    try {
      var resp = await rest.getRest("/books/$id", true, usr.token, 1, 100);

      cnsg = Consegna.fromJson(resp);

      return (cnsg);
    } catch (e) {
      return cnsg(error);
    }
  }
  */

  static Future postConsegna(User usr, int id, String st) async {
    dynamic data = {'idconsegna': id, 'st': st};
    late Consegna cnsg;
    try {
      var resp =
          await rest.postRest("/consegna/aggiorna", true, usr.token!, data);
      cnsg = Consegna.fromJson(resp);
      return (cnsg);
    } catch (e) {
      return Consegna(error: e.toString());
    }
  }
}
