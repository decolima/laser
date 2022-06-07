import '../entity/bkms.dart';
import '../entity/user.dart';
import '../service/rest.dart';

class userStore {
  String _usr = "";
  String _password = "";
  late User _user;
  var bkm = <Bkms>[];

  userStore(String usr, String pwd) {
    _usr = usr;
    _password = pwd;
  }

  getUser() {
    dynamic data = {'usr': _usr, 'pwd': _password};
    try {
      rest.postRest("/users/login", false, "", data).then((response) {
        _user = User.fromJson(response);

        print(_user.token);

        rest.getRest("/books", true, _user.token).then((respbkms) {
          for (var a in respbkms) {
            bkm.add(Bkms.fromJson(a));
          }
          print(bkm.length);
          for (var b in bkm) {
            print("Bkm :${b.descrizione} link: ${b.link} Autore: ${b.utente}");
          }
        });

        return _user;
      });
    } catch (e) {
      return e.toString();
    }
  }
}
