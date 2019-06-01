import 'package:flutter_course/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int _seletedProductIndex;

  List<Product> get products {
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
  }

  void selectProduct(int index) {
    _seletedProductIndex = index;
  }
}
