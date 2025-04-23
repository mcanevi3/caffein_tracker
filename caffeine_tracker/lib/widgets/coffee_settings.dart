import 'package:caffeine_tracker/brands_database_helper.dart';
import 'package:caffeine_tracker/coffee_database_helper.dart';
import 'package:flutter/material.dart';

class CoffeeSettings extends StatefulWidget {
  const CoffeeSettings({super.key});

  @override
  State<CoffeeSettings> createState() => _CoffeeSettingsState();
}

class _CoffeeSettingsState extends State<CoffeeSettings> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            CoffeeDatabaseHelper.instance.deleteAllCoffees();
            BrandsDatabaseHelper.instance.deleteAllBrands();
          },
          child: Row(
            children: [
              Icon(Icons.restore),
              SizedBox(width: 16),
              Text("Reset Database"),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
