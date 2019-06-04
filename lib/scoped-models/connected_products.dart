import 'dart:convert';

import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int _selProductIndex;
  User _autenticatedUser;
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'http://wallpaperswide.com/download/aerated_chocolate-wallpaper-1920x1080.jpg',
      'userEmail': _autenticatedUser.email,
      'userId': _autenticatedUser.id
    };
    return http
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
      _isLoading = false;
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

  Future<Null> updateProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'price': price,
      'image':
          'http://wallpaperswide.com/download/aerated_chocolate-wallpaper-1920x1080.jpg',
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId
    };
    return http
        .put(
            'https://flutter-course-products-c890a.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response respone) {
      _isLoading = false;
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
    });
  }

  Future<Null> deleteProduct() {
    _isLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(_selProductIndex);
    _selProductIndex = null;
    notifyListeners();
    return http
        .delete(
            'https://flutter-course-products-c890a.firebaseio.com/products/$deletedProductId.json')
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> fetchProducts() {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://flutter-course-products-c890a.firebaseio.com/products.json')
        .then((http.Response response) {
      _isLoading = false;
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            image: productData['image'],
            userEmail: productData['userEmail'],
            userId: productData['userId']);
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
    });
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

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
