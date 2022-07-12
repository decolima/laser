import '../entity/Consegna.dart';
import '../entity/User.dart';
import 'ConsegnaStore.dart';
import 'UserStore.dart';

class AppControl {
  static User? _usr;
  static final _cnsg = <Consegna>[];
  static int _index = -1;

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

  static addConsegna(Consegna c) {
    _cnsg.add(c);
  }

  static List<Consegna> getConsegna() {
    return _cnsg;
  }

  static clearConsegna() {
    _cnsg.clear();
  }

  static setIndex(int i) {
    _index = i;
  }

  static int getIndex() {
    return _index;
  }

  static Future CaricaConsegna() async {
    clearConsegna();
    return await ConsegnaStore.getConsegna(_usr!, 1, 100);
  }

  static Future AggConsegna(String st) async {
    await ConsegnaStore.postConsegna(_usr!, _cnsg[_index].id!, st);
    await CaricaConsegna();
    return true;
  }
}
