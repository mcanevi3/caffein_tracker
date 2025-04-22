import 'package:caffeine_tracker/widgets/coffee_editable_item.dart';
import 'package:flutter/material.dart';
import '../database_helper.dart';

class CoffeeListWidget extends StatefulWidget {
  const CoffeeListWidget({super.key});
  @override
  State<CoffeeListWidget> createState() => CoffeeListWidgetState();
}

class CoffeeListWidgetState extends State<CoffeeListWidget> {
  List<Map<String, dynamic>> _coffees = [];

  void refresh() {
    _loadCoffees();
  }

  @override
  void initState() {
    super.initState();
    _loadCoffees();
  }

  void _loadCoffees() async {
    final coffees = await DatabaseHelper.instance.getAllCoffees();
    setState(() {
      _coffees = coffees;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_coffees.isEmpty) {
      return const Center(child: Text('No coffees!'));
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _coffees.length,
      itemBuilder: (context, index) {
        final coffee = _coffees[index];
        return CoffeeEditableItem(
          id: coffee['uuid'] ?? "",
          brand: coffee['brand'] ?? "",
          name: coffee['name'] ?? "",
          caffeine: coffee['caffeine'].toString(),
          actionDelete: _deleteItem,
          deleteMsg: "Deleted from database!",
          actionUpdate: _updateItem,
          updateMsg: "Database updated!",
        );
      },
    );
  }

  void _updateItem(String id, String brand, String name, String caffeine) {
    DatabaseHelper.instance.updateCoffee(
      id,
      name,
      brand,
      int.tryParse(caffeine) ?? 0,
    );
    refresh();
  }

  void _deleteItem(String id) {
    DatabaseHelper.instance.deleteCoffee(id);
    refresh();
  }
}
