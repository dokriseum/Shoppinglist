import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ShoppingListScreen.dart';

class ShoppingListScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Einkaufsliste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: ShoppingListScreen(),
    );
  }
}