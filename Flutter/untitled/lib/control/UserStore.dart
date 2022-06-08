import '../entity/user.dart';
import '../service/rest.dart';

class userStore {

  static Future getUser(String usr, String pwd) async {
    dynamic data = {'usr': usr, 'pwd': pwd};
    late User _user;
    try {
      var resp = await rest.postRest("/users/login", false, "", data);
      _user = User.fromJson(resp);
      return (_user);

    } catch (e) {
      return User(
          error: e.toString(),
          firstName: "",
          lastName: "",
          mail: "",
          role: "",
          token: "",
          userid: 0);
    }
  }

  static Future posUser(
      String firstName, String lastName, String mail, String pwd) async {
    dynamic data = {
      'first_name': firstName,
      'last_name': lastName,
      'email': mail,
      'pwd': pwd,
      'roleuser': 'User'
    };
    late User _user;
    try {
      var resp = await rest.postRest("/users", false, "", data);
      _user = User.fromJson(resp);
      return (_user);


    } catch (e) {
      return User(
          error: e.toString(),
          firstName: "",
          lastName: "",
          mail: "",
          role: "",
          token: "",
          userid: 0);
    }
  }
}
