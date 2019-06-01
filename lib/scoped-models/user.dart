import 'package:flutter_course/models/user.dart';
import 'package:flutter_course/scoped-models/connected_products.dart';

mixin UserModel on ConnectedProducts {
  void login(String email, String password) {
    autenticatedUser = User(id: 'test', email: email, password: password);
  }
}
