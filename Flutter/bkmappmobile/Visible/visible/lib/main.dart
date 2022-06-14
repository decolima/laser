import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final key = GlobalKey<ScaffoldState>();

  bool isVisible = true;
  bool isTransparent = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        key: key,
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildBox(text: 'None', color: Colors.grey),
            const SizedBox(height: 16),
            Visibility(
              visible: isVisible,
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: buildBox(text: 'Visibilty', color: Colors.pink),
              ),
            ),
            IgnorePointer(
              ignoring: isTransparent,
              child: Opacity(
                opacity: isTransparent ? 0 : 1,
                child: buildBox(text: 'Opacity', color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            buildBox(text: 'None', color: Colors.grey),
            const SizedBox(height: 24),
            buildButton(
              text: 'Toggle Visibility',
              color: Colors.pink,
              onClicked: () => setState(() => isVisible = !isVisible),
            ),
            const SizedBox(height: 16),
            buildButton(
              text: 'Toggle Opacity',
              color: Colors.blue,
              onClicked: () => setState(() => isTransparent = !isTransparent),
            ),
          ],
        ),
      );

  Widget buildBox({
    required String text,
    required Color color,
  }) =>
      GestureDetector(
        onTap: () {
          final snackBar = SnackBar(
            padding: EdgeInsets.symmetric(vertical: 8),
            backgroundColor: color,
            content: Text(
              '$text is clickable!!',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          );

          key.currentState!
            ..removeCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
        child: Container(
          width: double.infinity,
          height: 80,
          color: color,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  Widget buildButton({
    required String text,
    required Color color,
    required VoidCallback onClicked,
  }) =>
      RaisedButton(
        color: color,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
        onPressed: onClicked,
        shape: StadiumBorder(),
        padding: EdgeInsets.symmetric(vertical: 16),
      );

  /*
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
  */
}

/*




class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
 
}
*/