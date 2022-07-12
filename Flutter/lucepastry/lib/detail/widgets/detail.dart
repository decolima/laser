import 'package:flutter/material.dart';
import 'package:lucepastry/Widgets/CustomAppBar.dart';
import 'package:lucepastry/detail/widgets/food_detail.dart';
import 'package:lucepastry/detail/widgets/food_img.dart';
import 'package:lucepastry/models/food.dart';

class DetailPage extends StatelessWidget {
  final Food food;
  DetailPage(this.food);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink,
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                Icons.arrow_back_ios_outlined,
                Icons.favorite_outline,
                leftCallback: () => Navigator.of(context).pop(),
              ),
              FoodImg(food),
              FoodDetail(food)
            ],
          ),
        ),
      floatingActionButton: Container(
        height: 56,
        width: 100,
        child: RawMaterialButton(
          fillColor: Colors.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.shopping_bag_outlined,
                color: Colors.black,
              size: 30),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Text(food.quantity.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),),
              )

            ],
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
