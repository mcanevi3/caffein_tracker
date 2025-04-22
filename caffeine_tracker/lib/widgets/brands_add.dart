import 'dart:io';

import 'package:caffeine_tracker/brands_database_helper.dart';
import 'package:caffeine_tracker/image_saver.dart';
import 'package:flutter/material.dart';

class BrandsAdd extends StatefulWidget {
  const BrandsAdd({super.key});

  @override
  State<BrandsAdd> createState() => _BrandsAddState();
}

class _BrandsAddState extends State<BrandsAdd> {
  TextEditingController brandNameController = TextEditingController();
  TextEditingController logoLinkController = TextEditingController();
  String lastLogo = "";

  List<Map<String, dynamic>> allBrands = [];

  @override
  void initState() {
    super.initState();
    print("called");
    loadBrands();
  }

  Future<void> loadBrands() async {
    allBrands = await BrandsDatabaseHelper.instance.getAllBrands();
    print(allBrands.toList());
  }

  // String? brandLogo = "Starbucks";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(labelText: "Brand Name:"),
          controller: brandNameController,
        ),
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(labelText: "Logo url"),
          controller: logoLinkController,
        ),
        SizedBox(height: 16),
        // Row(
        //   children: [
        //     Text("Logo:"),
        //     SizedBox(width: 14),
        //     DropdownButton<String>(
        //       hint: Text('Select a brand logo'),
        //       value: brandLogo,
        //       onChanged: (String? newValue) {
        //         setState(() {
        //           brandLogo = newValue;
        //         });
        //       },
        //       items:
        //           ["Starbucks", "Kahve Dünyası", "Burger King"]
        //               .map(
        //                 (brand) => DropdownMenuItem<String>(
        //                   value: brand,
        //                   child: Row(
        //                     children: [
        //                       Image.asset(
        //                         "lib/assets/logos/${getAssetName(brand)}.png",
        //                         width: 24,
        //                         height: 24,
        //                       ),
        //                       SizedBox(width: 8),
        //                       Text(brand),
        //                     ],
        //                   ),
        //                 ),
        //               )
        //               .toList(),
        //     ),
        //   ],
        // ),
        ElevatedButton(
          onPressed: () async {
            var brand = brandNameController.text;
            var logo = logoLinkController.text;
            String localPath = await downloadAndSaveImage(
              logo,
              "${getAssetName(brand)}.png",
            );
            print(localPath);
            BrandsDatabaseHelper.instance.insertBrand(brand, localPath);
            setState(() {
              lastLogo = localPath;
            });
          },
          child: Text("Add Brand"),
        ),
        SizedBox(height: 16),
        Image.file(File(lastLogo), width: 24, height: 24),
        SizedBox(height: 16),
        allBrands.isEmpty
            ? SizedBox.shrink()
            : ListView.builder(
              shrinkWrap: true,
              itemCount: allBrands.length,
              itemBuilder: (context, index) {
                final brand = allBrands[index];
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Image.file(File(brand['logo']), width: 48, height: 48),
                        Text(brand['name']),
                      ],
                    ),
                  ),
                );
              },
            ),
      ],
    );
  }

  String getAssetName(String brand) {
    return brand.toLowerCase().replaceAll(' ', '');
  }
}
