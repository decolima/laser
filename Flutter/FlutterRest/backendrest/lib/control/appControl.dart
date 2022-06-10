import 'package:backendrest/entity/bkms.dart';

import '../entity/user.dart';

class AppControl {
  static late User _usr;
  static final _bkms = <Bkms>[];
  static bool logged = false;

  static setUser(User u) {
    _usr = u;
  }

  static User getUser() {
    return _usr;
  }

  static addBkms(Bkms b) {
    _bkms.add(b);
  }

  static List<Bkms> getBkms() {
    return _bkms;
  }

  static clearBkms() {
    _bkms.clear();
  }
}
