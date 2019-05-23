import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';
//import 'package:flutter/rendering.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // theme: ThemeData(
      //   primarySwatch: Colors.red,
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Easy List'),
        ),
        body: ProductManager(),
      ),
    );
  }
}
