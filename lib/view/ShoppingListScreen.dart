import 'package:flutter/material.dart';

import '../model/Product.dart';
import 'AddProductScreen.dart';
import 'EditProductScreen.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Product> _products = [];
  bool _isDarkModeEnabled = false; // Variable, um den Dunkelmodusstatus zu speichern

  void _addProduct(String name, int quantity, String imageUrl) {
    setState(() {
      _products.add(Product(name, quantity, imageUrl));
    });
  }

  void _editProduct(int index, String name, int quantity, String imageUrl) {
    setState(() {
      _products[index] = Product(name, quantity, imageUrl);
    });
  }


  void _toggleDarkMode(bool darkMode) {
    setState(() {
      _isDarkModeEnabled = darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einkaufsliste'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Switch(
              value: _isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _isDarkModeEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          return Theme(
            data: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(_products[index].imageUrl),
                  ),
                  title: Text(_products[index].name),
                  subtitle: Text('Menge: ${_products[index].quantity}'),
                  onTap: () async {
                    // Hier kannst du die Bearbeitungsseite aufrufen und die bearbeiteten Daten empfangen
                    Product editedProduct = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProductScreen(product: _products[index])),
                    );
                    // Wenn das bearbeitete Produkt nicht null ist, aktualisiere das Produkt in der Liste
                    if (editedProduct != null) {
                      _editProduct(index, editedProduct.name, editedProduct.quantity, editedProduct.imageUrl);
                    }
                  }
                );
              },
            ),
          );
        },
      ),
      /**
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(_products[index].imageUrl), // PNG-Datei als Icon
            ),
            title: Text(_products[index].name),
            subtitle: Text('Menge: ${_products[index].quantity}'),
            onTap: () {
              // Hier kannst du eine Bearbeitungsseite aufrufen, um das Produkt zu bearbeiten.
            },
          );
        },
      ),
          */
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          ).then((newProduct) {
            if (newProduct != null) {
              _addProduct(newProduct.name, newProduct.quantity, newProduct.imageUrl);
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}