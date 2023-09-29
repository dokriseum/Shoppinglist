import 'package:flutter/material.dart';

import '../model/ShoppingItem.dart';

class ShoppingListView extends StatefulWidget {
  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  List<ShoppingItem> items = [];
  String newItemName = '';
  String newItemQuantity = '1';
  String newItemImageUrl = ''; // Neues Attribut für die Bild-URL
  final TextEditingController _quantityController = TextEditingController();

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
          _showNewItemDialog(); // Funktion aufrufen, um das Dialogfeld anzuzeigen
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNewItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Neues Produkt hinzufügen'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  newItemName = value;
                },
                decoration: InputDecoration(labelText: 'Produkt'),
              ),
              TextField(
                controller: _quantityController,
                onChanged: (value) {
                  newItemQuantity = value;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Anzahl'),
              ),
              TextField(
                onChanged: (value) {
                  newItemImageUrl = value;
                },
                decoration: InputDecoration(labelText: 'Bild URL'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hinzufügen'),
              onPressed: () {
                int quantity = int.tryParse(newItemQuantity) ?? 1;
                ShoppingItem newItem = ShoppingItem(name: newItemName, quantity: quantity, imageUrl: newItemImageUrl);
                setState(() {
                  items.add(newItem);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
