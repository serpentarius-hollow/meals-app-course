import 'package:flutter/material.dart';

import 'dummy_data.dart';
import 'models/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten-free': false,
    'lactose-free': false,
    'vegetarian': false,
    'vegan': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten-free'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose-free'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(dummyMeals.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: TabsScreen(
        favoriteMeals: _favoriteMeals,
      ),
      routes: {
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(
              meals: _availableMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isMealFavorite,
            ),
        SettingsScreen.routeName: (context) => SettingsScreen(
              saveFilters: _setFilters,
              currentFilters: _filters,
            ),
      },
      onGenerateRoute: (settings) {},
      onUnknownRoute: (settings) {},
    );
  }
}
