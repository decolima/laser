
import 'dart:ffi';
import '../entity/bkms.dart';
import '../entity/user.dart';
import '../service/rest.dart';

class bkmsStore {
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
      var resp = await rest.postRest("/books", true, usr.token, data);
      _bkms = Bkms.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          mail: "",
          idbkm: 0);
    }
  }

  static Future getBkms(User usr) async {
    //late Bkms _bkms;
    var _bkms = <Bkms>[];

    try {
      var resp = await rest.getRest("/books", true, usr.token);

      for (var b in resp) {
        print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
        _bkms.add(Bkms.fromJson(b));
      }

      return (_bkms);

      /*
        rest.getRest("/books", true, _user.token).then((respbkms) {
          for (var a in respbkms) {
            bkm.add(Bkms.fromJson(a));
          }
          print(bkm.length);
          for (var b in bkm) {
            print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
          }
        });
        */
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          mail: "",
          idbkm: 0);
    }
  }

  static Future getSingleBkms(User usr, String id) async {
    late Bkms _bkms;
    //var _bkms = <Bkms>[];

    try {
      var resp = await rest.getRest("/books/$id", true, usr.token);

      /*for (var b in resp) {
          print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
            _bkms.add(Bkms.fromJson(b));
         }*/

      _bkms = Bkms.fromJson(resp);

      return (_bkms);

      /*
        rest.getRest("/books", true, _user.token).then((respbkms) {
          for (var a in respbkms) {
            bkm.add(Bkms.fromJson(a));
          }
          print(bkm.length);
          for (var b in bkm) {
            print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
          }
        });
        */
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          mail: "",
          idbkm: 0);
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
    late Bkms _bkms;
    try {
      var resp = await rest.putRest("/books", true, usr.token, data);
      _bkms = Bkms.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return Bkms(
          error: e.toString(),
          descrizione: "",
          link: "",
          dtaggiornamento: "",
          condiviso: false,
          dtcreazione: "",
          motivorim: "",
          status: "",
          tags: "",
          utente: "",
          utenteagg: "",
          mail: "",
          idbkm: 0);
    }
  }
}
