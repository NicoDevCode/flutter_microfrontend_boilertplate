import 'package:mobx/mobx.dart';
import 'package:mf_auth/mf_auth.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final AuthStore _authStore;
  
  _ProfileStore(this._authStore);
  
  @computed
  User? get currentUser => _authStore.user;
  
  @computed
  bool get isLoggedIn => _authStore.isLoggedIn;
  
  @computed
  bool get isLoading => _authStore.isLoading;
  
  Future<void> refreshUserData() async {
    await _authStore.checkLoginStatus();
  }
} 