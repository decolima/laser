import '../entity/Bkms.dart';
import '../entity/User.dart';
import '../service/rest.dart';
import 'AppControl.dart';

class BkmsStore {
  static Future postBkms(
      User usr, String desc, String link, bool shared) async {
    dynamic data = {
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo',
      'motivorim': ""
    };
    late Bkms bkms;
    try {
      print(usr.mail);

      var resp = await rest.postRest("/books", true, usr.token, data);
      bkms = Bkms.fromJsonPost(resp);
      print(resp);
      return (bkms);
    } catch (e) {
      return Bkms(error: e.toString());
    }
  }

  static Future getBkms(User usr, int page, int size) async {
    var bkms = <Bkms>[];
    var resp = [];

    print(usr.firstName);

    try {
      resp = await rest.getRest("/books", true, usr.token, page, size);
      for (var a in resp) {
        print(a);
        bkms.add(Bkms.fromJson(a));
      }

      for (var b in bkms) {
        print("Add..${b.descrizione}");
        AppControl.addBkms(b);
      }
      return (true);
    } catch (e) {
      print(e);
      return Bkms(error: e.toString());
    }
  }

  static Future getSingleBkms(User usr, String id) async {
    late Bkms bkms;

    try {
      var resp = await rest.getRest("/books/$id", true, usr.token, 1, 100);

      bkms = Bkms.fromJson(resp);

      return (bkms);
    } catch (e) {
      return Bkms(error: e.toString());
    }
  }

  static Future putBkms(
      User usr, int id, String desc, String link, bool shared) async {
    dynamic data = {
      'id': id,
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo',
      'motivorim': ""
    };
    late Bkms bkms;
    try {
      var resp = await rest.putRest("/books", true, usr.token, data);
      bkms = Bkms.fromJson(resp);
      return (bkms);
    } catch (e) {
      return Bkms(error: e.toString());
    }
  }
}
