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
  TextEditingController logoKeyController = TextEditingController();
  String logoUrl = "";
  // 'https://logo.clearbit.com/starbucks.com',

  @override
  void initState() {
    super.initState();
    brandNameController.addListener(() {
      setState(() {
        logoKeyController.text = convertNameToKey(brandNameController.text);
      });
    });
    logoKeyController.addListener(() {
      setState(() {
        logoUrl = "https://logo.clearbit.com/${logoKeyController.text}.com";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Brand Name"),
            controller: brandNameController,
          ),
          SizedBox(height: 16),
          TextField(
            decoration: InputDecoration(labelText: "Logo"),
            controller: logoKeyController,
          ),
          SizedBox(height: 8),
          Image.network(
            logoUrl,
            width: 48,
            height: 48,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.error,
              ); // fallback if the image doesn't load
            },
          ),
          // ElevatedButton(
          //   onPressed: () async {
          //     var brand = brandNameController.text;
          //     var logo = logoLinkController.text;
          //     String localPath = await downloadAndSaveImage(
          //       logo,
          //       "${getAssetName(brand)}.png",
          //     );
          //     print(localPath);
          //     BrandsDatabaseHelper.instance.insertBrand(brand, localPath);
          //   },
          //   child: Text("Add Brand"),
          // ),
        ],
      ),
    );
  }

  String getAssetName(String brand) {
    return brand.toLowerCase().replaceAll(' ', '');
  }

  String convertNameToKey(String brandName) {
    return brandName
        .toLowerCase()
        .replaceAll(' ', '')
        .replaceAll('ı', 'i')
        .replaceAll('ğ', 'g')
        .replaceAll('ü', 'u')
        .replaceAll('ş', 's')
        .replaceAll('ö', 'o')
        .replaceAll('ç', 'c');
  }
}
