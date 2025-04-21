import 'package:caffeine_tracker/database_helper.dart';
import 'package:caffeine_tracker/widgets/coffee_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoffeeAddWidget extends StatefulWidget {
  final VoidCallback onCoffeeAdded;

  const CoffeeAddWidget({super.key, required this.onCoffeeAdded});

  @override
  State<CoffeeAddWidget> createState() => _CoffeeAddWidgetState();
}

class _CoffeeAddWidgetState extends State<CoffeeAddWidget> {
  final TextEditingController brandController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController caffeineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: brandController,
          decoration: const InputDecoration(labelText: "Drink Brand"),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Drink Name"),
        ),
        const SizedBox(height: 16),
        TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          controller: caffeineController,
          decoration: const InputDecoration(labelText: "Caffeine (mg)"),
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _addDrink, child: Text("Add Drink")),
      ],
    );
  }

  void _addDrink() {
    final String brand = brandController.text;
    final String name = nameController.text;
    final String caffeinText = caffeineController.text;

    if (brand.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in the brand field!")),
      );
      return;
    }
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in the name field!")),
      );
      return;
    }
    if (caffeinText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in the caffeine field!")),
      );
      return;
    }

    final int? caffeine = int.tryParse(caffeinText);
    if (caffeine == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a proper caffeine amount!")),
      );
      return;
    }
    DatabaseHelper.instance.insertCoffee(name, brand, caffeine);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Added to the database!")));

    brandController.clear();
    nameController.clear();
    caffeineController.clear();
    widget.onCoffeeAdded();
  }
}
