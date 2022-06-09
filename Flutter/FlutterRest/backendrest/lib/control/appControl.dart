import 'package:backendrest/entity/bkms.dart';

import '../entity/user.dart';

class appControl {
  static late User _usr;
  static var _bkms = <Bkms>[];

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
