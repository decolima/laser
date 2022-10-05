import 'package:segnalibro/control/SegnaLibroStore.dart';

import '../entity/SegnaLibro.dart';
import '../entity/User.dart';
import 'UserStore.dart';
import 'SegnaLibroStore.dart';

class AppControl {
  static SegnaLibro? _lastbkms;
  static User? _usr;
  static int _index = -1;
  static final _bkms = <SegnaLibro>[];

  static setLastBkms(SegnaLibro s) {
    _lastbkms = s;
  }

  static SegnaLibro? getLastBkms() {
    if (_lastbkms != null) {
      return _lastbkms;
    } else {
      SegnaLibro s = SegnaLibro();
      return s;
    }
  }

  static setUser(User u) {
    _usr = u;
  }

  static User? getUser() {
    if (_usr != null) {
      return _usr;
    } else {
      User u = User();
      return u;
    }
  }

  static Future<User?> LoginUser(String email, String pass) async {
    return await UserStore.getUser(email, pass);
  }

  static Future<User?> CreaUser(
      String nome, String cognome, String email, String pass) async {
    return await UserStore.creaUser(nome, cognome, email, pass);
  }

  static setIndex(int i) {
    _index = i;
  }

  static int getIndex() {
    return _index;
  }

  static addBkms(SegnaLibro b) {
    _bkms.add(b);
  }

  static List<SegnaLibro> getBkms() {
    return _bkms;
  }

  static clearBkms() {
    _bkms.clear();
  }

  static Future CaricaSegnaLibro() async {
    clearBkms();
    return await SegnaLibroStore.getBkms(_usr!);
  }

  static Future CreaSegnaLibro(
      String desc, String link, bool shared, String tags) async {
    _lastbkms = await SegnaLibroStore.postBkms(_usr!, desc, link, shared);

    if (tags.length > 0) {
      await AggEtichetta(true, tags);
    }

    await CaricaSegnaLibro();
    return true;
  }

  static Future AggSegnaLibro(
      String desc, String link, bool shared, String tags) async {
    _lastbkms = await SegnaLibroStore.putBkms(
        _usr!, _bkms[_index].idbkm!, desc, link, shared);

    if (tags.length > 0) {
      await AggEtichetta(false, tags);
    }

    await CaricaSegnaLibro();
    return true;
  }

  static Future AggEtichetta(bool newsl, String tags) async {
    String _i = "";

    if (newsl) {
      _i = getLastBkms()!.idbkm!;
    } else {
      _i = _bkms[_index].idbkm!;
    }

    await SegnaLibroStore.patchBkms(_usr!, _i, tags);

    await CaricaSegnaLibro();

    return true;
  }

  static Future delSegnaLibro() async {
    await SegnaLibroStore.delBkms(_usr!, _bkms[_index].idbkm!);
    await CaricaSegnaLibro();
    return true;
  }
}
