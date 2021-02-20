import 'package:app_for_ex/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filtersScreen';
  final Function setFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.setFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegeterian = false;
  bool _lactoseFree = false;
  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegan = widget.currentFilters['vegan'];
    _vegeterian = widget.currentFilters['vegeterian'];
    super.initState();
  }

  Widget _buildSwichListTile(
    bool glutenFree,
    String title,
    String description,
    Function updateValue,
  ) {
    return SwitchListTile(
      value: glutenFree,
      onChanged: updateValue,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final _filters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegeterian': _vegeterian,
              };
              widget.setFilters(_filters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust you meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwichListTile(
                  _glutenFree, 'Gluten-free', 'Only included gluten-free meals',
                  (value) {
                setState(() {
                  _glutenFree = value;
                });
              }),
              _buildSwichListTile(_lactoseFree, 'Lactose-free',
                  'Only included lactose-free meals', (value) {
                setState(() {
                  _lactoseFree = value;
                });
              }),
              _buildSwichListTile(
                  _vegeterian, 'Vegeterian', 'Only included vegeterian meals',
                  (value) {
                setState(() {
                  _vegeterian = value;
                });
              }),
              _buildSwichListTile(_vegan, 'Vegan', 'Only included vegan meals',
                  (value) {
                setState(() {
                  _vegan = value;
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
