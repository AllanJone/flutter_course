import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped-models/connected_products.dart';

mixin ProductsModel on ConnectedProducts {
  bool _showFavourites = false;

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get displayedProducts {
    if (_showFavourites) {
      return List.from(
          products.where((Product product) => product.isFavourite).toList());
    }
    return List.from(products);
  }

  int get selectedProductIndex {
    return selProductIndex;
  }

  Product get selectedProduct {
    if (selProductIndex == null) {
      return null;
    }
    return products[selProductIndex];
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  void updateProduct(
      String title, String description, double price, String image) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selProductIndex] = updatedProduct;
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavouriteStatus() {
    final bool newFavouriteStatus = !selectedProduct.isFavourite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavourite: newFavouriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    products[selProductIndex] = updatedProduct;
    notifyListeners();
    selProductIndex = null;
  }

  void selectProduct(int index) {
    selProductIndex = index;
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}
