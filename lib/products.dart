import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products({@required this.products}) : assert(products != null);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('assets/Elizabeth_Olsen.jpg'),
          Text(products[index]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Display'),
                onPressed: () {},
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
  // @override
  // Widget build(BuildContext context) {
  //   Widget productCard = Center(
  //     child: Text('No products found. Please add some.'),
  //   );
  //   if (products.length > 0) {
  //     productCard = ListView.builder(
  //       itemBuilder: _buildProductItem,
  //       itemCount: products.length,
  //     );
  //   }
  //   return productCard;
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return products.length > 0 ? ListView.builder(
  //     itemBuilder: _buildProductItem,
  //     itemCount: products.length,
  //   ) : Center(child: Text('No products found. Please add some.'),);
  // }
  //@override
  // Widget build(BuildContext context) {
  //   return ListView(
  //     children: products
  //         .map(
  //           (element) => Card(
  //                 child: Column(
  //                   children: <Widget>[
  //                     Image.asset('assets/Elizabeth_Olsen.jpg'),
  //                     Text(element),
  //                   ],
  //                 ),
  //               ),
  //         )
  //         .toList(),
  //   );
  // }
}
