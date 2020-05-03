import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List<Meal> displayedMeal;
  var _loadInitData = false;

  //You cant use context on initState because initState is called too early, before context exist
  @override
  void initState() {
    // final routeArgs =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryId = routeArgs['id'];
    // categoryTitle = routeArgs['title'];
    // displayedMeal = DUMMY_MEALS
    //     .where((meal) => meal.categories.contains(categoryId))
    //     .toList();
    super.initState();
  }

  //This will be trigger whenever the references of the state changes
  //This mean that when this widget is created it will called it too
  //Now we have to put that condiction first because _removeMeal() is called first
  //Thats cause didChangeDependencies() runs a couple of times after the initialization of the state
  @override
  void didChangeDependencies() {
    if(!_loadInitData ){
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeal = DUMMY_MEALS
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      _loadInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeal[index].id,
            title: displayedMeal[index].title,
            imageUrl: displayedMeal[index].imageUrl,
            duration: displayedMeal[index].duration,
            complexity: displayedMeal[index].complexity,
            affordability: displayedMeal[index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
