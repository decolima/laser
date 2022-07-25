import 'package:segnalibro/login.dart';

import '../../control/AppControl.dart';
import 'package:flutter/material.dart';
import 'entity/User.dart';
import 'listsegnalibro.dart';

class WidgetRegis extends StatefulWidget {
  @override
  State<WidgetRegis> createState() => _WidgetRegisState();
}

class _WidgetRegisState extends State<WidgetRegis> {
  TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController(text: '');
    final TextEditingController pass = TextEditingController(text: '');
    final TextEditingController nome = TextEditingController(text: '');
    final TextEditingController cognome = TextEditingController(text: '');

    final nomeField = TextField(
      controller: nome,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Nome",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final cognomeField = TextField(
      controller: cognome,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Cognome",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

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

    final buttonCrea = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
      child: ElevatedButton(
        child: const Text(
          "Crea Utenti",
          textAlign: TextAlign.center,
        ),
        onPressed: () async {
          User? u = await AppControl.CreaUser(
              nome.text, cognome.text, email.text, pass.text);
          if (u!.firstName != null) {
            _showDialogOk();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => WidgetLogin()));
          } else {
            _showDialogNOk();
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
              height: 20.0,
            ),
            nomeField,
            const SizedBox(
              height: 40.0,
            ),
            cognomeField,
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
            buttonCrea,
          ],
        ),
      )),
    ));
  }

  Future<void> _showDialogOk() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ok'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Utente Creato con Sucesso'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _showDialogNOk() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Non Ok'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Non è stato possibile creare utente'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
