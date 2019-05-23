import 'package:flutter/material.dart';
import 'package:flutter_course/product_control.dart';
import 'package:flutter_course/products.dart';

class ProductManager extends StatefulWidget {
  final String startingPoint;

  ProductManager({this.startingPoint});

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<Map<String, String>> _products = [];

  @override
  void initState() {
    if (widget.startingPoint != null)
      _products.add({
        'title': widget.startingPoint,
        'image': 'assets/Elizabeth_Olsen.jpg'
      });
    super.initState();
  }

  void _addProduct(Map<String, String> product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.0),
          child: ProductControl(
            addProduct: _addProduct,
          ),
        ),
        Expanded(
          child: Products(products: _products),
        ),
      ],
    );
  }
}
