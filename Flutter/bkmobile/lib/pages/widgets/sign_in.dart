import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../control/AppControl.dart';
import '../../control/UserStore.dart';
import '../../pages/login_page.dart';
import 'package:dio/dio.dart';
import '../../pages/Bookmarks.dart';
import '../../entity/user.dart';


class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureTextPassword = true;

  //final loginBkmApp _api = loginBkmApp();

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
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Card(
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          width: 500.0,
          child: Column(
            children: [
              _emailField(),
              const Divider(height: 0.0),
              _passwordField(),
              _signInButton()
            ],
          ),
        ),
      ),
    );
  }

  final TextEditingController email = TextEditingController(text: 'andre@bkmapp.it');

  Widget _emailField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
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
            icon: Icon(FontAwesomeIcons.envelope,
                color: Colors.black, size: 22.0),
          ),
          onSubmitted: (_) {
            _focusNodePassword.requestFocus();
          },
        ),
      );

  final TextEditingController pwd = TextEditingController(text: 'andre');
  Widget _passwordField() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
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
            icon: const Icon(FontAwesomeIcons.key,
                color: Colors.black, size: 22.0),
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
                  color: Colors.black),
            ),
          ),
          onSubmitted: (_) {
            // TODO Login
          },
          textInputAction: TextInputAction.go,
        ),
      );

  Widget _signInButton() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF00C853),
        ),
        child: const Text(
          'ACCEDI',
          style: TextStyle(fontSize: 20.0),
        ),
        onPressed: () async {
          var usr = await userStore.getUser(email.text, pwd.text);

          if (usr != null) {
            print(usr!.mail);

            appControl.setUser(usr);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Bookmarks(),
              ),
            );
          }
        }
      );
}
