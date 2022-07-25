import '../entity/SegnaLibro.dart';
import '../entity/User.dart';
import '../service/rest.dart';
import 'AppControl.dart';

class SegnaLibroStore {
  static Future postBkms(
      User usr, String desc, String link, bool shared) async {
    dynamic data = {
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo'
    };
    late SegnaLibro _bkms;
    try {
      print(usr.mail);

      var resp = await rest.postRest("/segnalibro", true, usr.token!, data);
      _bkms = SegnaLibro.fromJsonPost(resp);
      print(resp);
      return (_bkms);
    } catch (e) {
      return SegnaLibro(error: e.toString());
    }
  }

  static Future getBkms(User usr) async {
    var _bkms = <SegnaLibro>[];
    var resp = [];

    print(usr.firstName);

    try {
      resp = await rest.getRest("/segnalibro", true, usr.token!, 1, 100);
      resp.forEach((element) {
        print(element);
        _bkms.add(SegnaLibro.fromJson(element));
      });

      _bkms.forEach((b) {
        print("Add..${b.descrizione}");
        AppControl.addBkms(b);
      });
      return (true);
    } catch (e) {
      print(e);
      return SegnaLibro(error: e.toString());
    }
  }

  static Future getSingleBkms(User usr, String id) async {
    late SegnaLibro _bkms;

    try {
      var resp =
          await rest.getRest("/segnalibro/$id", true, usr.token!, 1, 100);

      _bkms = SegnaLibro.fromJson(resp);

      return (_bkms);
    } catch (e) {
      return SegnaLibro(error: e.toString());
    }
  }

  static Future putBkms(
      User usr, String id, String desc, String link, bool shared) async {
    dynamic data = {
      'id': id,
      'descrizione': desc,
      'link': link,
      'condiviso': shared,
      'status': 'Nuovo'
    };
    print("arrivato al put ....");
    late SegnaLibro _bkms;
    try {
      var resp = await rest.putRest("/segnalibro", true, usr.token!, data);
      _bkms = SegnaLibro.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return SegnaLibro(error: e.toString());
    }
  }

  static Future delBkms(User usr, String id) async {
    dynamic data = {'idBook': id};
    try {
      var resp = await rest.delRest("/segnalibro", true, usr.token!, data);
      return (resp);
    } catch (e) {
      return SegnaLibro(error: e.toString());
    }
  }

  static Future patchBkms(User usr, String id, String tags) async {
    dynamic data = {'idBook': id, 'Tags': tags};
    print("arrivato al put ....");
    late SegnaLibro _bkms;
    try {
      var resp = await rest.patchRest("/segnalibro", true, usr.token!, data);
      _bkms = SegnaLibro.fromJson(resp);
      return (_bkms);
    } catch (e) {
      return SegnaLibro(error: e.toString());
    }
  }
}
