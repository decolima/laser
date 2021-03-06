import 'package:amz/ListConsegna.dart';
import '../../control/AppControl.dart';
import 'package:flutter/material.dart';

class WidgetLogin extends StatefulWidget {
  @override
  State<WidgetLogin> createState() => _WidgetLoginState();
}

class _WidgetLoginState extends State<WidgetLogin> {
  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final TextEditingController email =
        TextEditingController(text: 'andre@amz.it');

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
            await AppControl.CaricaConsegna();
            //print(AppControl.getConsegna().length.toString());
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DoListConsegna()));
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
            const Image(
                image: AssetImage('assets/delivery.png'),
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
            buttonLogin,
          ],
        ),
      )),
    ));
  }
}
