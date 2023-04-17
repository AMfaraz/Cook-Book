import 'package:flutter/material.dart';
import 'package:mealer/widgets/meal_item.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "/category-meals";
  final List<Meal> availableMeals;

  CategoryMealsScreen({required this.availableMeals});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String? categoryTitle;
  late List<Meal> displayedMeals;

  var _loadedState=false;

  void initState(){

   //...
    super.initState();
  }

  void didChangeDependencies(){
    if(!_loadedState){

      final Map<String, String> routesArgs =
      (ModalRoute.of(context)?.settings.arguments) as Map<String, String>;
      categoryTitle = routesArgs["title"];
      final String? categoryId = routesArgs["id"];
      displayedMeals =widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedState=true;
    }
    super.didChangeDependencies();

  }

  void _removeMeal(String mealId){
    setState((){
      displayedMeals.removeWhere((meal) => meal.id==mealId);
    });
    }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayedMeals[index].id,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              title: displayedMeals[index].title,
              // removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
