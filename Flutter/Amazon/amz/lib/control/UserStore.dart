import 'package:amz/control/AppControl.dart';

import '../entity/User.dart';
import '../service/rest.dart';

class UserStore {
  static Future getUser(String usr, String pwd) async {
    dynamic data = {'usr': usr, 'pwd': pwd};
    late User user;
    try {
      var resp = await rest.postRest("/users/login", false, "", data);
      user = User.fromJson(resp);
      AppControl.setUser(user);
      return (user);
    } catch (e) {
      return User();
    }
  }

  static Future creaUser(
      String firstName, String lastName, String mail, String pwd) async {
    dynamic data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': mail,
      'pwd': pwd,
      'roleuser': 'User'
    };
    late User user;
    try {
      var resp = await rest.postRest("/users", false, "", data);
      user = User.fromJson(resp);
      return (user);
    } catch (e) {
      return User();
    }
  }
}
