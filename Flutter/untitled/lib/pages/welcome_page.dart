import 'package:flutter/material.dart';
import 'package:untitled/theme.dart';

import 'login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(64.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                CustomTheme.gradientStart,
                CustomTheme.gradientEnd,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 1.0),
            ),
          ),
          child: Column(
            children: [_welcomeWidget(), _signInButton(context)],
          ),
        ),
      );

  Widget _welcomeWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
                image: AssetImage('assets/images/Photo.png'),
                fit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Text(
                'Bookmarks App',
                style: TextStyle(fontSize: 50, color: Color(0xFF004D40) , shadows: [
                  Shadow(
                      color: Color(0xFF00C583), offset: Offset(1, 4), blurRadius: 1),
                  Shadow(
                      color: Colors.lightGreenAccent, offset: Offset(2, 1), blurRadius: 2)
                ],

                ),
              ),
            ),
          ],
        ),
      );
  Widget _signInButton(BuildContext context) => ElevatedButton(
  style: ElevatedButton.styleFrom(primary: Color(0xFF00C853),
  ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 48.0),
          child: Text(
            'INIZIA',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
      );
}
