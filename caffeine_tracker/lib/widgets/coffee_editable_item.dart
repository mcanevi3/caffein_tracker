import 'package:flutter/material.dart';

class CoffeeEditableItem extends StatefulWidget {
  final String id;
  final String brand;
  final String name;
  final String caffeine;
  final Function(String) actionDelete;
  final String deleteMsg;

  const CoffeeEditableItem({
    super.key,
    required this.id,
    required this.brand,
    required this.name,
    required this.caffeine,
    required this.actionDelete,
    required this.deleteMsg,
  });

  @override
  State<CoffeeEditableItem> createState() => _CoffeeEditableItemState();
}

class _CoffeeEditableItemState extends State<CoffeeEditableItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.name),
        subtitle: Text('${widget.brand} - ${widget.caffeine} mg ${widget.id}'),
        trailing: SizedBox(
          width: 80,
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.draw)),
              IconButton(
                onPressed: () {
                  widget.actionDelete(widget.id);
                  if (widget.deleteMsg.isNotEmpty) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(widget.deleteMsg)));
                  }
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
