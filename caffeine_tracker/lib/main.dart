import 'package:flutter/material.dart';
import 'widgets/coffee_list_widget.dart';

void main() {
  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffein tracking',
      home: const DrinkLoggerScreen(),
    );
  }
}

class DrinkLoggerScreen extends StatefulWidget {
  const DrinkLoggerScreen({super.key});

  @override
  State<DrinkLoggerScreen> createState() => _DrinkLoggerScreenState();
}

class _DrinkLoggerScreenState extends State<DrinkLoggerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _caffeineController = TextEditingController();

  void _logDrink() {
    final String name = _nameController.text;
    final String caffeineText = _caffeineController.text;

    if (name.isEmpty || caffeineText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in both fields!")),
      );
      return;
    }

    final int? caffeine = int.tryParse(caffeineText);
    if (caffeine == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid caffeine data!")),
      );
    }
    print("$caffeine mg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add your drink!")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Drink name"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _caffeineController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Caffeine (mg)"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _logDrink, child: Text("Log drink")),
            const SizedBox(height: 24),
            const Expanded(child: CoffeeListWidget()),
          ],
        ),
      ),
    );
  }
}
