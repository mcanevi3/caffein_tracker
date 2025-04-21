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
        );
        // return Card(
        //   child: ListTile(
        //     title: Text(coffee['name']),
        //     subtitle: Text(
        //       '${coffee['brand']} - ${coffee['caffeine']} mg ${coffee['uuid']}',
        //     ),
        //     trailing: SizedBox(
        //       width: 80,
        //       child: Row(
        //         children: [
        //           IconButton(onPressed: () {}, icon: const Icon(Icons.draw)),
        //           IconButton(
        //             onPressed: () {
        //               _deleteItem(coffee['uuid']);
        //               refresh();
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 const SnackBar(
        //                   content: Text("Deleted from the database!"),
        //                 ),
        //               );
        //             },
        //             icon: const Icon(Icons.delete),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }

  void _deleteItem(String id) {
    DatabaseHelper.instance.deleteCoffee(id);
    refresh();
  }
}
