import 'dart:async';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  ProductPage({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageUrl),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(title),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  color: Theme.of(context).buttonColor,
                  onPressed: () => Navigator.pop(context, true),
                  child: Text('DELETE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
