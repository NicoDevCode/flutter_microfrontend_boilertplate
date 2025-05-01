import 'package:get_it/get_it.dart';
import 'package:mf_auth/mf_auth.dart';
import 'package:mf_profile/src/presentation/store/profile_store.dart';

class ProfileModule {
  static final GetIt _getIt = GetIt.instance;
  
  static Future<void> init() async {
    // Registramos los stores
    _getIt.registerLazySingleton<ProfileStore>(
      () => ProfileStore(_getIt<AuthStore>()),
    );
  }
  
  static void dispose() {
    if (_getIt.isRegistered<ProfileStore>()) {
      _getIt.unregister<ProfileStore>();
    }
  }
} 