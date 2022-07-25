import '../../control/AppControl.dart';
import 'package:flutter/material.dart';
import 'listsegnalibro.dart';
import 'registrazione.dart';

class WidgetLogin extends StatefulWidget {
  @override
  State<WidgetLogin> createState() => _WidgetLoginState();
}

class _WidgetLoginState extends State<WidgetLogin> {
  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final TextEditingController email =
        TextEditingController(text: 'andre@sgn.it');

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
          await AppControl.LoginUser(email.text, pass.text);
          if (AppControl.getUser()!.firstName != null) {
            await AppControl.CaricaSegnaLibro();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Listbkm()));
          }
        },
      ),
    );

    final buttonRegis = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
          child: const Text(
            "Registrazione",
            textAlign: TextAlign.center,
          ),
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => WidgetRegis()));
          }),
    );

    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const Image(
                image: AssetImage('assets/segnalibro_lg.png'),
                height: 350,
                width: 350),
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
            Row(
              children: [
                const SizedBox(width: 100.0),
                buttonLogin,
                const SizedBox(width: 70.0),
                buttonRegis
              ],
            ),
          ],
        ),
      )),
    ));
  }
}
