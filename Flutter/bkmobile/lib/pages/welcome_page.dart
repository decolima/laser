import 'package:flutter/material.dart';
import 'login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(58.0),
          decoration:
              const BoxDecoration(color: Color.fromRGBO(225, 237, 249, 1.0)),
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
              padding: EdgeInsets.only(top: 50.0),
              child: Text(
                'LinkTogether App',
                style: TextStyle(
                  fontSize: 40,
                  color: Color.fromRGBO(139, 0, 0, 1),
                ),
              ),
            ),
          ],
        ),
      );
  Widget _signInButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
            builder: (context) => LoginPage(),
          ),
        ),
      );
}
