import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = "/meal-detail";

  final Function toggleFavourite;
  final Function isMealFavourtie;

  MealDetail({required this.toggleFavourite,required this.isMealFavourtie});


  Widget buildSectionTile(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              buildSectionTile(context, "Ingredients"),
              buildContainer(
                ListView.builder(
                    itemCount: selectedMeal.ingredients.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(selectedMeal.ingredients[index]),
                        ),
                      );
                    }),
              ),
              buildSectionTile(context, "Steps"),
              buildContainer(
                ListView.builder(
                    itemCount: selectedMeal.steps.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children:<Widget> [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('#${index + 1}'),
                            ),
                            title: Text(selectedMeal.steps[index]),
                          ),
                          const Divider(),
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        // child: Icon(Icons.delete),
        child:Icon(isMealFavourtie(mealId)? Icons.star:Icons.star_border),
        // onPressed: (){
        //   Navigator.of(context).pop(mealId);
        // },
        onPressed:(){
          toggleFavourite(mealId);
        },
      ),
    );
  }
}
