import 'dart:async';

import 'package:mf_auth/src/domain/entity/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  
  Future<bool> logout();
  
  Future<bool> isLoggedIn();
  
  Future<void> saveLoginStatus(bool status);
} 