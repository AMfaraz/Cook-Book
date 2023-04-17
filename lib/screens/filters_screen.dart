import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {

  static const routeName = "/filters";

 final Function saveFilters;
 final Map<String,bool> currentFilters;

  FilterScreen({required this.saveFilters,required this.currentFilters});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _gluttenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lactoseFree = false;

  @override
  initState(){
    _gluttenFree=widget.currentFilters["gluten"]??false;
    _lactoseFree=widget.currentFilters["lactose"]??false;
    _vegan=widget.currentFilters["vegan"]??false;
    _vegetarian=widget.currentFilters["vegetarian"]??false;

    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, ValueChanged<bool>? updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
            onPressed:() {
            final selectedfilters={
              "gluten":_gluttenFree,
              "lactose":_lactoseFree,
              "vegan":_vegan,
              "vegetarian":_vegetarian,
            };
             widget.saveFilters(selectedfilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          //switches
          Expanded(
            child: ListView(
              children: <Widget>[
                //builder function
                _buildSwitchListTile(
                    "Glutten Free", "Only glutten free meals", _gluttenFree,
                     (newValue) {
                  setState(() {
                    _gluttenFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegan", "Only vegan meals", _vegan,
                        (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    "Vegatarian ", "Only Vegetarian meals", _vegetarian,
                        (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    "Lactose Free", "Only Lactose free meals", _lactoseFree,
                        (newValue) {
                      setState(() {
                        _gluttenFree = newValue;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
