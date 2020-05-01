import 'package:flutter/material.dart';
import 'package:navigation_screens/categories_screen.dart';

class CategoryMealsScreen extends StatelessWidget {
  final String id;
  final String categoryTitle;

  CategoryMealsScreen(this.id, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('The Recipes for the Category'),
      ),
    );
  }
}
