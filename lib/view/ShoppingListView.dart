import 'package:flutter/material.dart';

import '../model/ShoppingItem.dart';


class ShoppingListView extends StatefulWidget {
  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  List<ShoppingItem> items = [];
  String newItemName = '';
  int newItemQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einkaufsliste'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            subtitle: Text('Menge: ${items[index].quantity}'),
            onLongPress: () {
              setState(() {
                items.removeAt(index);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addItem() {
    setState(() {
      var newItem = ShoppingItem(name: newItemName, quantity: newItemQuantity);
      items.add(newItem);
      // Hier kannst du die Synchronisierung mit anderen Geräten implementieren
      // Zum Beispiel über eine Datenbank oder Cloud-Speicher
      newItemName = '';
      newItemQuantity = 1;
    });
  }
}

void main() => runApp(MaterialApp(home: ShoppingListView()));
