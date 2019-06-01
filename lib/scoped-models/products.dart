import 'package:flutter_course/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

mixin ProductsModel on Model {
  List<Product> _products = [];
  int _seletedProductIndex;
  bool _showFavourites = false;

  List<Product> get products {
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
    return _seletedProductIndex;
  }

  Product get selectedProduct {
    if (_seletedProductIndex == null) {
      return null;
    }
    return _products[_seletedProductIndex];
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  void addProduct(Product product) {
    _products.add(product);
    _seletedProductIndex = null;
    notifyListeners();
  }

  void updateProduct(Product product) {
    _products[_seletedProductIndex] = product;
    _seletedProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_seletedProductIndex);
    _seletedProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavouriteStatus() {
    final bool newFavouriteStatus = !selectedProduct.isFavourite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavourite: newFavouriteStatus);
    updateProduct(updatedProduct);
    notifyListeners();
    _seletedProductIndex = null;
  }

  void selectProduct(int index) {
    _seletedProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}
