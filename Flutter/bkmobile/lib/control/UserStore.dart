import '../entity/User.dart';
import '../service/rest.dart';

class UserStore {
  static Future getUser(String usr, String pwd) async {
    dynamic data = {'usr': usr, 'pwd': pwd};
    late User _user;
    try {
      var resp = await rest.postRest("/users/login", false, "", data);
      _user = User.fromJson(resp);
      return (_user);

      /*
        rest.getRest("/books", true, _user.token).then((respbkms) {
          for (var a in respbkms) {
            bkm.add(Bkms.fromJson(a));
          }
          print(bkm.length);
          for (var b in bkm) {
            print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
          }
        });
        */
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

  static Future creaUser(
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

      /*
        rest.getRest("/books", true, _user.token).then((respbkms) {
          for (var a in respbkms) {
            bkm.add(Bkms.fromJson(a));
          }
          print(bkm.length);
          for (var b in bkm) {
            print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
          }
        });
        */
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
