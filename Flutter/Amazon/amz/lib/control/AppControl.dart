import '../entity/Consegna.dart';
import '../entity/User.dart';

class AppControl {
  static User? _usr;
  static final _cnsg = <Consegna>[];

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

  static addConsegna(Consegna c) {
    _cnsg.add(c);
  }

  static List<Consegna> getConsegna() {
    return _cnsg;
  }

  static clearConsegna() {
    _cnsg.clear();
  }
}
