import 'package:app_for_ex/models/meal.dart';
import 'package:app_for_ex/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routeName = '/category-meal_screen';
  final List<Meal> avaibleMeals;
  CategoryMealScreen(this.avaibleMeals);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String title;
  List<Meal> categoryMeal;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final id = routeArgs['id'];
      //   print(id);
      categoryMeal = widget.avaibleMeals.where((element) {
        return element.categories.contains(id);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void removeItem(String mealId) {
    setState(() {
      categoryMeal.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('category meal'),
      ),
      body: Center(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeal[index].id,
            title: categoryMeal[index].title,
            imageUrl: categoryMeal[index].imageUrl,
            duration: categoryMeal[index].duration,
            complexity: categoryMeal[index].complexity,
            affordability: categoryMeal[index].affordability,
            //  removeItem: removeItem,
          );
        },
        itemCount: categoryMeal.length,
      )),
    );
  }
}
