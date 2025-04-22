import 'package:flutter/material.dart';

class BrandsAdd extends StatefulWidget {
  const BrandsAdd({super.key});

  @override
  State<BrandsAdd> createState() => _BrandsAddState();
}

class _BrandsAddState extends State<BrandsAdd> {
  TextEditingController brandNameController = TextEditingController();
  String? brandLogo = "Starbucks";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Brand Name:"),
          controller: brandNameController,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text("Logo:"),
            SizedBox(width: 14),
            DropdownButton<String>(
              hint: Text('Select a brand logo'),
              value: brandLogo,
              onChanged: (String? newValue) {
                setState(() {
                  brandLogo = newValue;
                });
              },
              items:
                  ["Starbucks", "Burger King", "Pepsi"]
                      .map(
                        (brand) => DropdownMenuItem<String>(
                          value: brand,
                          child: Row(
                            children: [
                              Image.asset(
                                "lib/assets/logos/starbucks.png",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Text(brand),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
        ElevatedButton(onPressed: () {}, child: Text("Add Brand")),
      ],
    );
  }
}
