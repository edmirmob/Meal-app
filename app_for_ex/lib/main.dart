import 'package:app_for_ex/dummy_data.dart';
import 'package:app_for_ex/models/meal.dart';
import 'package:app_for_ex/sceeens/filters_screen.dart';
import 'package:app_for_ex/sceeens/meal_detail_screen.dart';

import 'package:app_for_ex/sceeens/category_meal_screens.dart';
import 'package:app_for_ex/sceeens/category_screen.dart';
import 'package:app_for_ex/sceeens/tabs_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,

    
    'vegeterian': false,
  };
  List<Meal> _avaibleMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];
  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;
      _avaibleMeal = DUMMY_MEALS.where((element) {
        if (_filters['gluten'] && !element.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !element.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !element.isVegan) {
          return false;
        }
        if (_filters['vegeterian'] && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toogleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeal.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeal
            .add(DUMMY_MEALS.firstWhere((element) => (element.id == mealId)));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeal.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 224, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(_favoriteMeal),
        CategoryMealScreen.routeName: (context) =>
            CategoryMealScreen(_avaibleMeal),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toogleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
    );
  }
}
