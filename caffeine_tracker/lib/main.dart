import 'package:caffeine_tracker/widgets/coffee_add_widget.dart';
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
    return MaterialApp(title: 'Caffein tracking', home: CoffeeHomeScreen());
  }
}

class CoffeeHomeScreen extends StatelessWidget {
  CoffeeHomeScreen({super.key});
  final GlobalKey<CoffeeListWidgetState> _coffeeListKey =
      GlobalKey<CoffeeListWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add your drink!")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CoffeeListWidget(key: _coffeeListKey),
            SizedBox(height: 16),
            CoffeeAddWidget(
              onCoffeeAdded: () {
                _coffeeListKey.currentState?.refresh();
              },
            ),
          ],
        ),
      ),
    );
  }
}
