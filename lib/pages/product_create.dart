import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage({this.addProduct});

  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue = 0.0;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      onSaved: (String value) {
        print('Title saved');
        setState(() {
          _titleValue = value;
        });
      },
      //autovalidate: true,
      validator: (String value) {
        //if (value.trim().length <= 0)
        if (value.isEmpty || value.length < 5)
          return 'Title is required and should be 5+ characters long';
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 2,
      onSaved: (String value) {
        print('Description saved');
        setState(() {
          _descriptionValue = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 10)
          return 'Description is required and should be 10+ characters long';
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        print('Price saved');
        setState(() {
          _priceValue = double.parse(value);
        });
      },
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value))
          return 'Description is required and should be a number';
      },
    );
  }

  void _submitForm() {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500 : deviceWidth * 0.95;
    final targetPadding = deviceWidth - targetWidth;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formkey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              child: Text('SAVE'),
              onPressed: _submitForm,
            ),
            // GestureDetector(
            //   onTap: _submitForm,
            //   child: Container(
            //     color: Colors.lightBlue,
            //     padding: EdgeInsets.all(5.0),
            //     child: Text('My Button'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
