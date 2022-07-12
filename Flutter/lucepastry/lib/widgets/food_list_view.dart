import 'package:flutter/material.dart';
import 'package:lucepastry/detail/widgets/detail.dart';

import '../models/pastry.dart';
import 'food_item.dart';

class FoodListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final Pastry pastry;
  FoodListView(this.selected, this.callback, this.pageController, this.pastry);

  @override
  Widget build(BuildContext context) {
    final category = pastry.menu.keys.toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: PageView(
          controller: PageController(),
          onPageChanged: (index) => callback(index),
          children: category
              .map((e) => ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) =>
                      GestureDetector(
                        onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailPage(pastry.menu[category[selected]]![index])));
                        },
                          child: FoodItem(pastry.menu[category[selected]]![index])),
                  separatorBuilder: (_, index) => SizedBox(height: 15),
                  itemCount: pastry.menu[category[selected]]!.length))
              .toList()),
    );
  }
}
