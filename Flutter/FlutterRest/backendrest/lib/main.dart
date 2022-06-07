import 'package:backendrest/control/UserStore.dart';
import 'package:flutter/material.dart';

import 'entity/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoListUtenti(),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Text("Nome do Usuario"),
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WidgetLogin(),
    );
  }
}

class WidgetLogin extends StatefulWidget {
  const WidgetLogin({Key? key}) : super(key: key);

  @override
  State<WidgetLogin> createState() => _WidgetLoginState();
}

class _WidgetLoginState extends State<WidgetLogin> {
  
    TextStyle style = const TextStyle(fontFamily: "Montserrat", fontSize: 20.0);

    final TextEditingController email = TextEditingController(text: '');
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

    final TextEditingController pass = TextEditingController(text: '');
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
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          var user = userStore(email.text, pass.text).getUser();
          print(user);
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
                      children: <Widget>[
                      const SizedBox(height: 40.0),
                      emailField,
                      const SizedBox(height: 40.0),
                      passwordField,
                      const SizedBox(height: 40.0),
                      Row(
                        children: [
                            Column(
                                children: [buttonLogin],
                            )
                        ],
                      )
                      ],
                  ),
                  )
              ),
         );
    ))
}

