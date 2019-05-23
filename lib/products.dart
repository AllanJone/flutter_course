import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products({this.products});

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Display'),
                  onPressed: () => Navigator.pushNamed<bool>(
                      context, '/product/' + index.toString()))
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    Widget productCards = Center(
      child: Text('No products found. Please add some.'),
    );
    if (products != null && products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: _buildProductItem,
        itemCount: products.length,
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
