import 'dart:async';

import 'package:mf_auth/src/domain/entity/user.dart';
import 'package:mf_auth/src/domain/repository/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  // constantes y valores por defecto
  static const String IS_LOGGED_IN = "is_logged_in";
  static const String USER_ID = "user_id";
  static const String USER_EMAIL = "user_email";
  static const String USER_NAME = "user_name";
  
  final SharedPreferences _sharedPreferences;
  
  // constructor
  AuthRepositoryImpl(this._sharedPreferences);

  @override
  Future<User> login(String email, String password) async {
    // Simulamos una llamada a API
    await Future.delayed(const Duration(seconds: 1));
    
    // Validación simple
    if (email.isNotEmpty && password.isNotEmpty) {
      // Creamos un usuario ficticio para demostración
      final user = User(
        id: '1',
        email: email,
        name: email.split('@').first,
      );
      
      // Guardamos la información
      await _sharedPreferences.setBool(IS_LOGGED_IN, true);
      await _sharedPreferences.setString(USER_ID, user.id ?? '');
      await _sharedPreferences.setString(USER_EMAIL, user.email ?? '');
      await _sharedPreferences.setString(USER_NAME, user.name ?? '');
      
      return user;
    } else {
      throw Exception('Credenciales inválidas');
    }
  }

  @override
  Future<bool> logout() async {
    await _sharedPreferences.setBool(IS_LOGGED_IN, false);
    await _sharedPreferences.remove(USER_ID);
    await _sharedPreferences.remove(USER_EMAIL);
    await _sharedPreferences.remove(USER_NAME);
    
    return true;
  }

  @override
  Future<bool> isLoggedIn() async {
    return _sharedPreferences.getBool(IS_LOGGED_IN) ?? false;
  }
  
  @override
  Future<void> saveLoginStatus(bool status) async {
    await _sharedPreferences.setBool(IS_LOGGED_IN, status);
  }
  
  // Métodos adicionales para recuperar la información del usuario
  Future<User?> getCurrentUser() async {
    final isLoggedIn = await this.isLoggedIn();
    
    if (isLoggedIn) {
      return User(
        id: _sharedPreferences.getString(USER_ID),
        email: _sharedPreferences.getString(USER_EMAIL),
        name: _sharedPreferences.getString(USER_NAME),
      );
    }
    
    return null;
  }
} 