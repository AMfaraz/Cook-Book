import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealer/screens/categories_screen.dart';
import 'package:mealer/screens/favourite_screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  TabScreen({required this.favouriteMeals});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  late List<Map<String, dynamic >> pages;

  @override
  void initState(){
    pages= [
      {"page": CategoriesScreen(), "title": "Categories"},
      {"page": FavouriteScreen(favouriteMeals: widget.favouriteMeals), "title": "Favourites"},
    ];

    super.initState();
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //topbar

    // return DefaultTabController(
    //     length: 2,
    //     initialIndex: 0,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: const Text("Meals"),
    //         bottom: const TabBar(
    //             tabs:<Widget>[
    //               Tab(
    //                   icon: Icon(Icons.category,),
    //                   text: "Categories" ,
    //               ),
    //               Tab(
    //                 icon: Icon(Icons.star),
    //                 text: "Favourites",
    //               ),
    //             ]
    //         ),
    //       ),
    //       body: TabBarView(
    //           children: <Widget>[
    //             CategoriesScreen(),
    //             const FavouriteScreen(),
    //           ]
    //       ),
    //     ),
    // );

    //bottom bar
    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]["title"]),
      ),
      drawer: MainDrawer(),
      body: pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _selectedPageIndex,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 18,
          unselectedFontSize: 13,
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.category,
              ),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.star,
              ),
              label: "Favourites",
            ),
          ]),
    );
  }
}
