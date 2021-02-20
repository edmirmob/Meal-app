import 'package:app_for_ex/models/meal.dart';
import 'package:app_for_ex/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> listFavoriteMeal;
  FavoriteScreen(this.listFavoriteMeal);
  @override
  Widget build(BuildContext context) {
    if (listFavoriteMeal.isEmpty) {
      return Center(
        child: Text('You have no favorite yet, start adding some!'),
      );
    } else {
      return ListView.builder(
        itemCount: listFavoriteMeal.length,
        itemBuilder: (context, index) {
          return MealItem(
            id: listFavoriteMeal[index].id,
            title: listFavoriteMeal[index].title,
            imageUrl: listFavoriteMeal[index].imageUrl,
            duration: listFavoriteMeal[index].duration,
            complexity: listFavoriteMeal[index].complexity,
            affordability: listFavoriteMeal[index].affordability,
          );
        },
      );
    }
  }
}
