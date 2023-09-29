import 'package:flutter/material.dart';

import '../model/Product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _quantityController = TextEditingController(text: widget.product.quantity.toString());
    _imageUrlController = TextEditingController(text: widget.product.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produkt bearbeiten'),
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
                // Hier kannst du die bearbeiteten Daten zurückgeben
                Product editedProduct = Product(
                  _nameController.text,
                  int.parse(_quantityController.text),
                  _imageUrlController.text,
                );
                Navigator.pop(context, editedProduct);
              },
              child: Text('Änderungen speichern'),
            ),
          ],
        ),
      ),
    );
  }
}
