import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/products/products.dart';

import '../models/product.dart';

class ProductsPage extends StatelessWidget {
  final List<Product> products;

  ProductsPage({this.products});

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('Product List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_align_center),
            onPressed: () {},
          ),
        ],
      ),
      body: Products(products: products),
    );
  }
}
