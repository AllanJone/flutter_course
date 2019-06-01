import 'package:flutter_course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  User _autenticatedUser;

  void login(String email, String password) {
    _autenticatedUser = User(id: 'test', email: email, password: password);
  }
}
