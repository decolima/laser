import 'package:flutter/material.dart';
import 'package:lucepastry/Widgets/CustomAppBar.dart';
import 'package:lucepastry/Widgets/food_list.dart';
import '../models/pastry.dart';
import 'Widgets/food_list_view.dart';
import 'Widgets/pastry_info.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selected = 0;
  final pageController = PageController();
  final pastry = Pastry.generatePastry();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            Icons.arrow_back_ios_outlined,
            Icons.search_outlined,
          ),
          PastryInfo(),
          FoodList(selected, (int index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }, pastry),
          Expanded(
            child: FoodListView(selected, (int index) {
              setState(() {
                selected = index;
              });
            }, pageController, pastry),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pink,
        child: const Icon(Icons.shopping_bag_outlined,
            color: Colors.black, size: 30),
      ),
    );
  }
}
