import 'package:flutter/material.dart';

class ShoppingListView extends StatefulWidget {
  @override
  _ShoppingListViewState createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  List<ShoppingItem> items = [];
  String newItemName = '';
  String newItemQuantity = '1'; // Anzahl als Zeichenkette, um die Eingabe zu verarbeiten
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
          _showNewItemDialog();
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
                int quantity = int.tryParse(newItemQuantity) ?? 1; // Konvertiere zu einer Zahl oder verwende 1 als Standardwert
                ShoppingItem newItem = ShoppingItem(name: newItemName, quantity: quantity);
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

class ShoppingItem {
  String name;
  int quantity;

  ShoppingItem({required this.name, required this.quantity});
}

//void main() => runApp(MaterialApp(home: ShoppingListView()));
