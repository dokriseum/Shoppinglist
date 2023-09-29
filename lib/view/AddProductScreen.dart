import 'package:flutter/material.dart';

import '../model/Product.dart';

class AddProductScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neues Produkt hinzufügen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Produktname'),
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Menge'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Bild URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Hier kannst du die eingegebenen Daten übernehmen und zurückgeben.
                Navigator.pop(
                  context,
                  Product(
                    _nameController.text,
                    int.parse(_quantityController.text),
                    _imageUrlController.text,
                  ),
                );
              },
              child: Text('Produkt hinzufügen'),
            ),
          ],
        ),
      ),
    );
  }
}