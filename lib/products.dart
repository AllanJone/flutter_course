import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;

  Products({@required this.products}) : assert(products != null);

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
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ProductPage(
                              title: products[index]['title'],
                              imageUrl: products[index]['image'],
                            ),
                      ),
                    ),
              )
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
    if (products.length > 0) {
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
