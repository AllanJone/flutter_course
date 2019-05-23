import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl({this.addProduct}) : assert(addProduct != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        //color: Theme.of(context).primaryColor,
        child: Text('Add Product'),
        onPressed: () {
          addProduct('Scarlet Witch');
        });
  }
}
