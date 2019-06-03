import 'dart:convert';

import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int _selProductIndex;
  User _autenticatedUser;

  void addProduct(
      String title, String description, double price, String image) {
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'http://wallpaperswide.com/download/aerated_chocolate-wallpaper-1920x1080.jpg'
    };
    http
        .post(
            'https://flutter-course-products-c890a.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: _autenticatedUser.email,
          userId: _autenticatedUser.id);
      _products.add(newProduct);
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavourites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavourites) {
      return List.from(
          _products.where((Product product) => product.isFavourite).toList());
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (_selProductIndex == null) {
      return null;
    }
    return _products[_selProductIndex];
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  void updateProduct(
      String title, String description, double price, String image) {
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selProductIndex] = updatedProduct;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selProductIndex);
    notifyListeners();
  }

  void fetchProducts() {
    http
        .post(
            'https://flutter-course-products-c890a.firebaseio.com/products.json')
        .then((http.Response response) {});
  }

  void toggleProductFavouriteStatus() {
    final bool newFavouriteStatus = !selectedProduct.isFavourite;
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavourite: newFavouriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selProductIndex] = updatedProduct;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}

mixin UserModel on ConnectedProductsModel {
  void login(String email, String password) {
    _autenticatedUser = User(id: 'test', email: email, password: password);
  }
}
