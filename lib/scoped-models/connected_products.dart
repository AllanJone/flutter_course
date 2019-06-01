import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ConnectedProducts on Model {
  List<Product> products = [];
  int selProductIndex;
  User autenticatedUser;

  void addProduct(
      String title, String description, double price, String image) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: autenticatedUser.email,
        userId: autenticatedUser.id);
    products.add(newProduct);
    selProductIndex = null;
    notifyListeners();
  }
}
