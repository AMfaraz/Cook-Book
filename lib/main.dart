import 'package:flutter/material.dart';
import 'package:mealer/dummy_data.dart';

import 'package:mealer/screens/category_meals_screen.dart';
import 'package:mealer/screens/filters_screen.dart';
import 'package:mealer/screens/meal_detail.dart';
import 'models/meal.dart';
import 'screens/categories_screen.dart';
import 'screens/tabs_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map <String,bool> _filters={
    "gluten":false,
    "lactose":false,
    "vegan":false,
    "vegetarian":false,
  };

  // late Map<String,bool> _filters;

  List<Meal> _availableMeals=DUMMY_MEALS;

  List<Meal> _favouriteMeals=[];

  void _setFilters(Map<String,bool> filterData){
      setState((){
        _filters=filterData;

        // Map<String,bool> _filters=filterData;
        _availableMeals=DUMMY_MEALS.where((meal) {
          if(_filters["gluten"]==true && !meal.isGlutenFree){
            return false;
          }
          if(_filters["lactose"]==true && !meal.isLactoseFree){
            return false;
          }
          if(_filters["vegan"]==true && !meal.isVegan){
            return false;
          }
          if(_filters["vegetarian"]==true && !meal.isVegetarian){
            return false;
          }
          return true;
        }).toList();
      });
  }

  void _toggleFavourite(String mealId){
    final existingIndex=_favouriteMeals.indexWhere((meal) => meal.id==mealId);
    if(existingIndex>=0){
      setState((){
        _favouriteMeals.removeAt(existingIndex);
      });
    }

    else{
      setState((){
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId
        ));
      });
    }
  }

  bool _isMealFavourtie(String id){
    return _favouriteMeals.any((meal) => meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mealer',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyMedium:const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodySmall:const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          titleLarge:const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        ),
      ),
      // home:CategoriesScreen(),
      routes: {
        '/':(ctx)=> TabScreen(favouriteMeals: _favouriteMeals),
        CategoryMealsScreen.routeName:(ctx)=> CategoryMealsScreen(availableMeals:_availableMeals),
        MealDetail.routeName:(ctx)=> MealDetail(toggleFavourite: _toggleFavourite,isMealFavourtie: _isMealFavourtie),
        FilterScreen.routeName:(ctx)=> FilterScreen(saveFilters: _setFilters,currentFilters: _filters,),
      },
    );
  }
}

