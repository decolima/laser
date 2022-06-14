import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/control/UserStore.dart';
import '../../pages/login_page.dart';
//import 'package:untitled/pages/Rest/regis.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureTextPassword = true;

  final _focusNodeFirstName = FocusNode();
  final _focusNodeLastName = FocusNode();
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: _containerField()),
    );
  }

  Widget _containerField() => Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            _firstNameField(),
            _lastNameField(),
            _emailField(),
            _passwordField(),
            _signUpButton(context)
          ],
        ),
      );

  final TextEditingController firstname = TextEditingController(text: '');
  Widget _firstNameField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: TextField(
          controller: firstname,
          focusNode: _focusNodeFirstName,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Nome',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
          onSubmitted: (_) {
            _focusNodeLastName.requestFocus();
          },
        ),
      );

  final TextEditingController lastname = TextEditingController(text: '');
  Widget _lastNameField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: TextField(
          controller: lastname,
          focusNode: _focusNodeLastName,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Cognome',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
          onSubmitted: (_) {
            _focusNodeEmail.requestFocus();
          },
        ),
      );

  final TextEditingController email = TextEditingController(text: '');
  Widget _emailField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: TextField(
          controller: email,
          focusNode: _focusNodeEmail,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Indirizzo Email',
            hintStyle: TextStyle(fontSize: 17.0),
          ),
          onSubmitted: (_) {
            _focusNodePassword.requestFocus();
          },
        ),
      );

  final TextEditingController pwd = TextEditingController(text: '');
  Widget _passwordField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
        child: TextField(
          controller: pwd,
          focusNode: _focusNodePassword,
          obscureText: _obscureTextPassword,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
            hintStyle: const TextStyle(fontSize: 17.0),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureTextPassword = !_obscureTextPassword;
                });
              },
              child: Icon(
                  _obscureTextPassword
                      ? FontAwesomeIcons.eye
                      : FontAwesomeIcons.eyeSlash,
                  size: 15.0,
                  color: Colors.teal),
            ),
          ),
          onSubmitted: (_) {
            // TODO Login
          },
          textInputAction: TextInputAction.go,
        ),
      );

  Widget _signUpButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text(
          'REGISTRATI',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () async {
          var user = await UserStore.creaUser(
              firstname.text, lastname.text, email.text, pwd.text);
          if (user != null) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
      );
}
