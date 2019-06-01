import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../../scoped-models/products.dart';
import '../../models/product.dart';
import '../products/product_card.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    Widget productCards = Center(
      child: Text('No products found. Please add some.'),
    );
    if (products != null && products.length > 0) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return _buildProductList(model.products);
      },
    );
  }
}
