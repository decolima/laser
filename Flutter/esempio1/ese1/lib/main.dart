import 'package:flutter/material.dart';

void main() {
  // O método runApp() inicializa o layouta da app
  // MyApp() é um widget que será a raiz da nossa aplicação
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Explorando Widgets"),
        ),
        body: myWidgetCol(),
      ),
    );
  }
}

Widget myWidget() {
  return const TextField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(80))),
        hintText: 'Escreva alguma coisa aqui...'),
    style: TextStyle(color: Colors.lime),
  );
}

Widget myWidget1() {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
      "Ola terra",
      style: TextStyle(fontSize: 20),
    ),
  );
}

Widget myWidget2() {
  return FloatingActionButton(
    backgroundColor: Colors.red,
    elevation: 4.0,
    splashColor: Colors.yellow,
    onPressed: () {},
    child: const Text(
      'Login',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget myWidgetCol() {
  return Column(children: [
    myWidget(),
    myWidget(),
    myWidget2(),
  ]);
}
