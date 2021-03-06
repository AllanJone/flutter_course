import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:flutter_course/widgets/helpers/ensure_visible.dart';

import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          labelText: 'Product Title',
        ),
        initialValue: product == null ? '' : product.title.toString(),
        onSaved: (String value) {
          print('Title saved');
          _formData['title'] = value;
        },
        //autovalidate: true,
        validator: (String value) {
          //if (value.trim().length <= 0)
          if (value.isEmpty || value.length < 5)
            return 'Title is required and should be 5+ characters long';
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 2,
        initialValue: product == null ? '' : product.description.toString(),
        onSaved: (String value) {
          print('Description saved');
          _formData['description'] = value;
        },
        validator: (String value) {
          if (value.isEmpty || value.length < 10)
            return 'Description is required and should be 10+ characters long';
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(labelText: 'Product Price'),
        keyboardType: TextInputType.number,
        initialValue: product == null ? '' : product.price.toString(),
        onSaved: (String value) {
          print('Price saved');
          _formData['price'] =
              double.parse(value.replaceFirst(RegExp(r','), '.'));
        },
        validator: (String value) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value))
            return 'Description is required and should be a number';
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RaisedButton(
                child: Text('SAVE'),
                onPressed: () => _submitForm(
                    model.addProduct,
                    model.updateProduct,
                    model.selectProduct,
                    model.selectedProductIndex),
              );
      },
    );
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(
                height: 10.0,
              ),
              _buildSubmitButton(),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //     color: Colors.lightBlue,
              //     padding: EdgeInsets.all(5.0),
              //     child: Text('My Button'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function selectProduct,
      [int selectedProductIndex]) {
    if (!_formkey.currentState.validate()) {
      return;
    }
    _formkey.currentState.save();
    if (selectedProductIndex == -1) {
      addProduct(_formData['title'], _formData['description'],
              _formData['price'], _formData['image'])
          .then((bool sucess) {
        if (sucess) {
          Navigator.pushReplacementNamed(context, '/products')
              .then((_) => selectProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Okay'),
                    ),
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(_formData['title'], _formData['description'],
              _formData['price'], _formData['image'])
          .then((_) => Navigator.pushReplacementNamed(context, '/products')
              .then((_) => selectProduct(null)));
    }
    Navigator.pushReplacementNamed(context, '/products')
        .then((_) => selectProduct(null));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == -1
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
