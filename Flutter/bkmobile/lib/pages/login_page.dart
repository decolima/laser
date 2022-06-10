import 'package:flutter/material.dart';
import '../misc/bubble_indicator_painter.dart';
import '../pages/widgets/sign_in.dart';
import '../pages/widgets/sign_up.dart';

import '../theme.dart';

class LoginPage extends StatefulWidget {
 
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late PageController _pageController;
  Color signIn = Colors.black;
  Color signUp = Colors.white;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(64.0),
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
              children: [
                _logoWidget(),
                selectorWidget(),
                _pageViewWidget(),
              ],
            ),
          ),
        ),
      );
  Widget _logoWidget() => const Padding(
        padding: EdgeInsets.only(top: 58.0),
        child: Image(
            image: AssetImage('assets/images/login_logo.png'), height: 105.0),
      );
  Widget selectorWidget() => Container(
        decoration: const BoxDecoration(
          color: Color(0x552B2B2B),
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
        width: 300.0,
        height: 50.0,
        margin: const EdgeInsets.only(top: 40.0),
        child: CustomPaint(
          painter: BubbleIndicatorPainter(pageController: _pageController),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Text(
                    'Accedi',
                    style: TextStyle(color: signIn, fontSize: 16.0),
                  ),
                  onPressed: () => _pageController.animateToPage(0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      Colors.transparent,
                    ),
                  ),
                  child: Text(
                    'Registrati',
                    style: TextStyle(color: signUp, fontSize: 16.0),
                  ),
                  onPressed: () => _pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.decelerate),
                ),
              ),
            ],
          ),
        ),
      );
  Widget _pageViewWidget() => Expanded(
          child: PageView(
        onPageChanged: (index) {
          setState(() {
            signIn = index == 0 ? Colors.black : Colors.white;
            signUp = index == 1 ? Colors.black : Colors.white;
          });
        },
        controller: _pageController,
        children: [
          SignIn(),
          SignUp(),
        ],
      ));
}
