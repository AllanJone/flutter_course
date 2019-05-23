import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String titleValue = '';
  String descriptionValue = '';
  double priceValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Product Title',
            ),
            onChanged: (String value) {
              setState(() {
                titleValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Description'),
            maxLines: 2,
            onChanged: (String value) {
              setState(() {
                descriptionValue = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                priceValue = double.parse(value);
              });
            },
          ),
        ],
      ),
    );
  }
}
