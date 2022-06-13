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
    late Bkms _bkms;
    try {
      print(usr.mail);

      var resp = await rest.postRest("/books", true, usr.token, data);
      _bkms = Bkms.fromJsonPost(resp);
      print(resp);
      return (_bkms);
    } catch (e) {
      return Bkms(error: e.toString());
    }
  }

  static Future getBkms(User usr) async {
    var _bkms = <Bkms>[];
    var resp = [];

    print(usr.firstName);

    try {
      resp = await rest.getRest("/books", true, usr.token, 1, 100);
      resp.forEach((element) {
        print(element);
        _bkms.add(Bkms.fromJson(element));
      });

      _bkms.forEach((b) {
        print("Add..${b.descrizione}");
        AppControl.addBkms(b);
      });
      return (true);
    } catch (e) {
      print(e);
      return Bkms(error: e.toString());
    }
  }

  static Future getSingleBkms(User usr, String id) async {
    late Bkms _bkms;

    try {
      var resp = await rest.getRest("/books/$id", true, usr.token, 1, 100);

      _bkms = Bkms.fromJson(resp);

      return (_bkms);
    } catch (e) {
      return Bkms(error: e.toString());
    }
  }

  static Future putBkms(
      User usr, String id, String desc, String link, bool shared) async {
    dynamic data = {
      'id': id,
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo',
      'motivorim': ""
    };
    print("arrivato al put ....");
    late Bkms _bkms;
    try {
      var resp = await rest.putRest("/books", true, usr.token, data);
      _bkms = Bkms.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return Bkms(error: e.toString());
    }
  }
}
