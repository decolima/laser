import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/historical_page.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('box');
  box.put('name', 'Lucia');

  print('Name: ${box.get('name')}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mutua',
        home: HistoricalPage()
    );
  }
}