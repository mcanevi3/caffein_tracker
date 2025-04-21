import 'package:flutter/material.dart';
import '../database_helper.dart';

class CoffeeListWidget extends StatefulWidget {
  const CoffeeListWidget({super.key});
  @override
  State<CoffeeListWidget> createState() => _CoffeeListWidgetState();
}

class _CoffeeListWidgetState extends State<CoffeeListWidget> {
  List<Map<String, dynamic>> _coffees = [];

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
      itemCount: _coffees.length,
      itemBuilder: (context, index) {
        final coffee = _coffees[index];
        return Card(
          child: ListTile(
            title: Text(coffee['name']),
            subtitle: Text('${coffee['brand']} - ${coffee['caffeine']} mg'),
          ),
        );
      },
    );
  }
}
