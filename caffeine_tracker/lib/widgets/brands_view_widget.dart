import 'dart:io';

import 'package:caffeine_tracker/brands_database_helper.dart';
import 'package:flutter/material.dart';

class BrandsViewWidget extends StatefulWidget {
  const BrandsViewWidget({super.key});

  @override
  State<BrandsViewWidget> createState() => _BrandsViewWidgetState();
}

class _BrandsViewWidgetState extends State<BrandsViewWidget> {
  late List<Map<String, dynamic>> _brands = [];

  @override
  void initState() {
    super.initState();
    loadBrands();
  }

  loadBrands() async {
    var brands = await BrandsDatabaseHelper.instance.getAllBrands();
    setState(() {
      _brands = brands;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_brands.isEmpty) return Center(child: Text('No brands!'));

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _brands.length,
      itemBuilder: (context, index) {
        final brand = _brands[index];
        return brand["name"].isEmpty
            ? SizedBox.shrink()
            : Card(
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
    );
  }
}
