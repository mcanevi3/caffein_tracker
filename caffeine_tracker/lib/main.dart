import 'package:caffeine_tracker/widgets/coffee_settings.dart';
import 'package:flutter/material.dart';
import 'widgets/coffee_list_widget.dart';
import 'widgets/coffee_add_widget.dart';

enum AppPage { addCoffee, viewCoffee, settingsCoffee }

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caffeine Tracker',
      home: const CoffeeApp(),
    ),
  );
}

class CoffeeApp extends StatefulWidget {
  const CoffeeApp({super.key});

  @override
  State<CoffeeApp> createState() => _CoffeeAppState();
}

class _CoffeeAppState extends State<CoffeeApp> {
  AppPage _selectedPage = AppPage.viewCoffee;
  final GlobalKey<CoffeeListWidgetState> _coffeeListKey = GlobalKey();

  void _onCoffeeAdded() {
    _coffeeListKey.currentState?.refresh();
    setState(() {
      _selectedPage = AppPage.viewCoffee;
    });
  }

  Widget _buildBody() {
    switch (_selectedPage) {
      case AppPage.addCoffee:
        return CoffeeAddWidget(onCoffeeAdded: _onCoffeeAdded);
      case AppPage.viewCoffee:
        return CoffeeListWidget(key: _coffeeListKey);
      case AppPage.settingsCoffee:
        return CoffeeSettings();
    }
  }

  void _selectPage(AppPage page) {
    setState(() {
      _selectedPage = page;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Builder(
          builder: (drawerContext) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.brown[200]),
                  child: const Text(
                    "Menu",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: Text("Add Coffee"),
                  onTap: () {
                    Navigator.pop(drawerContext);
                    _selectPage(AppPage.addCoffee);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.local_cafe),
                  title: Text("View Coffees"),
                  onTap: () {
                    Navigator.pop(drawerContext);
                    _selectPage(AppPage.viewCoffee);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text("Settings"),
                  onTap: () {
                    Navigator.pop(drawerContext);
                    _selectPage(AppPage.settingsCoffee);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: _buildBody(),
    );
  }
}
