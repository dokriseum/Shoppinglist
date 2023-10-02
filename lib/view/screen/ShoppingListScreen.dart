import 'package:flutter/material.dart';

import '../../model/Product.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  bool darkMode = false;
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Einkaufsliste'),
        actions: [
          IconButton(
            icon: Icon(darkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                darkMode = !darkMode;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(products[index].name),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              setState(() {
                products.removeAt(index);
              });
            },
            child: ListTile(
              onTap: () {
                _editProduct(products[index]);
              },
              leading: Image.asset('assets/${products[index].image}.png', height: 50, width: 50),
              title: Text(products[index].name),
              subtitle: Text('Menge: ${products[index].quantity}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addProduct();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addProduct() async {
    Product newProduct = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        int quantity = 1;
        String image = 'default'; // Default-Bild

        return AlertDialog(
          title: Text('Neues Produkt hinzufügen'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(labelText: 'Produktname'),
              ),
              TextField(
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
                decoration: InputDecoration(labelText: 'Menge'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: image,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      image = newValue;
                    });
                  }
                },

                items: <String>['default', 'apple', 'banana', 'orange']
                    .map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text('Hinzufügen'),
              onPressed: () {
                Navigator.of(context).pop(Product(name, quantity, image));
              },
            ),
          ],
        );
      },
    );

    if (newProduct != null) {
      setState(() {
        products.add(newProduct);
      });
    }
  }

  void _editProduct(Product product) async {
    Product editedProduct = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = product.name;
        int quantity = product.quantity;
        String image = product.image;

        return AlertDialog(
          title: Text('Produkt bearbeiten'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  name = value;
                },
                controller: TextEditingController(text: name),
                decoration: InputDecoration(labelText: 'Produktname'),
              ),
              TextField(
                onChanged: (value) {
                  quantity = int.tryParse(value) ?? 1;
                },
                controller: TextEditingController(text: quantity.toString()),
                decoration: InputDecoration(labelText: 'Menge'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                value: image,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      image = newValue;
                    });
                  }
                },

                items: <String>['default', 'apple', 'banana', 'orange']
                    .map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
            TextButton(
              child: Text('Speichern'),
              onPressed: () {
                Navigator.of(context).pop(Product(name, quantity, image));
              },
            ),
          ],
        );
      },
    );

    if (editedProduct != null) {
      setState(() {
        products[products.indexOf(product)] = editedProduct;
      });
    }
  }
}
