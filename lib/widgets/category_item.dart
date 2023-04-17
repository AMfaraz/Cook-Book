import 'package:flutter/material.dart';
import 'package:mealer/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final Color color;

  CategoryItem({required this.color, required this.title, required this.id});

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
        CategoryMealsScreen.routeName, arguments: {"id": id, "title": title}
    );
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme
          .of(context)
          .primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .titleLarge,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
