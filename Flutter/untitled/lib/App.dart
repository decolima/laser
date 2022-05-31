import 'package:flutter/material.dart';
import 'package:untitled/pages/welcome_page.dart';
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => const MaterialApp(
      title: 'Bookmarks App',
    home: WelcomePage(),
    debugShowCheckedModeBanner: false,
    );

}