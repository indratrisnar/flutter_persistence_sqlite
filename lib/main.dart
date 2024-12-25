import 'package:flutter/material.dart';
import 'package:flutter_persistence_sqlite/models/cat.dart';
import 'package:flutter_persistence_sqlite/pages/add_cat_page.dart';
import 'package:flutter_persistence_sqlite/pages/cats_page.dart';
import 'package:flutter_persistence_sqlite/pages/update_cat_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatsPage(),
      routes: {
        '/cat/add': (context) => AddCatPage(),
        '/cat/update': (context) {
          final oldCat = ModalRoute.of(context)!.settings.arguments as Cat;
          return UpdateCatPage(oldCat: oldCat);
        },
      },
    );
  }
}
