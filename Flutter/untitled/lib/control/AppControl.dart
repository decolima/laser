import 'package:untitled/entity/user.dart';

 class appControl {
  static User? usr;

  static User? getUser() {
    return usr;
  }

  static setUser(User u) {
    usr = u;
  }
}