import '../entity/Bkms.dart';
import '../entity/User.dart';


class AppControl {
  static User? _usr;
  static final _bkms = <Bkms>[];
  static int _index = -1;

  static setIndex(int i){
    _index = i;
  }

  static getIndex(){
   return _index;
  }


  static setUser(User u) {
    _usr = u;
  }

  static User? getUser() {
    if (_usr != null) {
      return _usr;
    } else {
      User u = User(
          userid: 0,
          firstName: "",
          lastName: "",
          mail: "",
          role: "",
          token: "",
          error: "");
      return u;
    }
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
