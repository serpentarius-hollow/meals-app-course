import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  final Function(Map<String, bool> val) saveFilters;
  final Map<String, bool> currentFilters;

  const SettingsScreen({
    Key? key,
    required this.saveFilters,
    required this.currentFilters,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters['gluten-free'] ?? false;
    _lactoseFree = widget.currentFilters['lactose-free'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten-free': _glutenFree,
                'lactose-free': _lactoseFree,
                'vegetarian': _vegetarian,
                'vegan': _vegan,
              };
              widget.saveFilters(selectedFilters);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meals selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTile(
                  'Gluten Free',
                  'Only include gluten free meals',
                  _glutenFree,
                  (value) {
                    setState(() {
                      _glutenFree = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Lactose Free',
                  'Only include lactose free meals',
                  _lactoseFree,
                  (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegetarian',
                  'Only include Vegetarian meals',
                  _vegetarian,
                  (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  },
                ),
                _buildSwitchTile(
                  'Vegan',
                  'Only include vegan meals',
                  _vegan,
                  (value) {
                    setState(() {
                      _vegan = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
