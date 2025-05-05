import 'package:mf_auth/src/domain/entity/user.dart';
import 'package:mf_auth/src/domain/repository/auth_repository.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  // constructor:---------------------------------------------------------------
  _AuthStore(this._authRepository);

  // repository:----------------------------------------------------------------
  final AuthRepository _authRepository;

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoading = false;

  @observable
  bool success = false;

  @observable
  User? user;

  @observable
  String errorMessage = '';

  @computed
  bool get isLoggedIn => user != null;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> login(String email, String password) async {
    this.errorMessage = '';
    this.isLoading = true;
    this.success = false;

    try {
      this.user = await _authRepository.login(email, password);
      this.success = true;
      
      // Notificamos a otros módulos que el usuario ha iniciado sesión
      GlobalEventBus.instance.fire(UserLoggedInEvent(user?.id ?? ''));
    } catch (e) {
      this.errorMessage = e.toString();
    } finally {
      this.isLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    this.isLoading = true;
    
    try {
      await _authRepository.logout();
      this.user = null;
      this.success = false;
      
      // Notificamos a otros módulos que el usuario ha cerrado sesión
      GlobalEventBus.instance.fire(UserLogoutEvent());
    } catch (e) {
      this.errorMessage = e.toString();
    } finally {
      this.isLoading = false;
    }
  }
  
  @action
  Future<void> checkLoginStatus() async {
    this.isLoading = true;
    
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      
      if (isLoggedIn) {
        // Si estamos utilizando el método adicional que agregamos
        this.user = await (_authRepository as dynamic).getCurrentUser();
        this.success = true;
      } else {
        this.user = null;
        this.success = false;
      }
    } catch (e) {
      this.errorMessage = e.toString();
      this.user = null;
    } finally {
      this.isLoading = false;
    }
  }
} 