import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoffeeEditableItem extends StatefulWidget {
  final String id;
  final String brand;
  final String name;
  final String caffeine;
  final Function(String) actionDelete;
  final String deleteMsg;
  final Function(String, String, String, String) actionUpdate;
  final String updateMsg;

  const CoffeeEditableItem({
    super.key,
    required this.id,
    required this.brand,
    required this.name,
    required this.caffeine,
    required this.actionDelete,
    required this.deleteMsg,
    required this.actionUpdate,
    required this.updateMsg,
  });

  @override
  State<CoffeeEditableItem> createState() => _CoffeeEditableItemState();
}

class _CoffeeEditableItemState extends State<CoffeeEditableItem> {
  bool editable = false;
  late TextEditingController brandController = TextEditingController(text: "");
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController caffeineController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    brandController = TextEditingController(text: widget.brand);
    nameController = TextEditingController(text: widget.name);
    caffeineController = TextEditingController(text: widget.caffeine);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title:
            editable
                ? TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Name"),
                )
                : Text(widget.name),
        subtitle:
            editable
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: brandController,
                      decoration: InputDecoration(labelText: "Brand"),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: caffeineController,
                      decoration: InputDecoration(labelText: "Caffeine"),
                    ),
                  ],
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(widget.brand), Text('${widget.caffeine} mg')],
                ),
        trailing: SizedBox(
          width: 96,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (editable) {
                    var modified =
                        (nameController.text.replaceAll(' ', '') ==
                            widget.name.replaceAll(' ', '')) &&
                        (brandController.text.replaceAll(' ', '') ==
                            widget.brand.replaceAll(' ', '')) &&
                        (caffeineController.text.replaceAll(' ', '') ==
                            widget.caffeine.replaceAll(' ', ''));
                    if (!modified) {
                      widget.actionUpdate(
                        widget.id,
                        brandController.text,
                        nameController.text,
                        caffeineController.text,
                      );
                      if (widget.updateMsg.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(widget.updateMsg)),
                        );
                      }
                    }
                  }
                  setState(() {
                    editable = !editable;
                  });
                },
                icon: editable ? Icon(Icons.check) : Icon(Icons.create_rounded),
              ),
              editable
                  ? SizedBox.shrink()
                  : IconButton(
                    onPressed: () {
                      widget.actionDelete(widget.id);
                      if (widget.deleteMsg.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(widget.deleteMsg)),
                        );
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
