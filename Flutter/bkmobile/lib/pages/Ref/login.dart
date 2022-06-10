import '../../control/appControl.dart';
import 'package:flutter/material.dart';
import '../../control/UserStore.dart';
import '../../control/BkmsStore.dart';
import 'bookmarks.dart';

class WidgetLogin extends StatefulWidget {
  @override
  State<WidgetLogin> createState() => _WidgetLoginState();
}

class _WidgetLoginState extends State<WidgetLogin> {
  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);
  //late User user;
  //late userStore usrControl;

  @override
  Widget build(BuildContext context) {
    final TextEditingController email =
        TextEditingController(text: 'andre@bkmapp.it');
    final TextEditingController pass = TextEditingController(text: 'andre');

    final emailField = TextField(
      controller: email,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      controller: pass,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final buttonLogin = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Login",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          var user = await userStore.getUser(email.text, pass.text);
          if (user != null) {
            appControl.setUser(user);
            bkmsStore.getBkms(appControl.getUser());
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => bookmarks()));
          }
        },
      ),
    );

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            emailField,
            const SizedBox(
              height: 40.0,
            ),
            passwordField,
            const SizedBox(
              height: 40.0,
            ),
            buttonLogin,
          ],
        ),
      )),
    ));
  }
}
