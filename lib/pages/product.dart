import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/Elizabeth_Olsen.jpg'),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Details'),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: FlatButton(
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
