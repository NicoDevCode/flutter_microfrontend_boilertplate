import 'package:get_it/get_it.dart';
import 'package:mf_auth/src/data/repository/auth_repository_impl.dart';
import 'package:mf_auth/src/domain/repository/auth_repository.dart';
import 'package:mf_auth/src/presentation/store/auth_store.dart';
import 'package:mf_auth/src/presentation/store/form_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModule {
  static final GetIt _getIt = GetIt.instance;
  static bool _initialized = false;
  
  static Future<void> init() async {
    if (_initialized) return;
    
    // Obtenemos la instancia de SharedPreferences
    if (!_getIt.isRegistered<SharedPreferences>()) {
      final sharedPreferences = await SharedPreferences.getInstance();
      _getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    }
    
    // Registramos el repositorio
    _getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(_getIt<SharedPreferences>()),
    );
    
    // Registramos los stores
    _getIt.registerLazySingleton<FormStore>(
      () => FormStore(),
    );
    
    _getIt.registerLazySingleton<AuthStore>(
      () => AuthStore(_getIt<AuthRepository>()),
    );
    
    // Verificamos el estado de autenticación de forma asíncrona
    // No bloqueamos la inicialización completa
    _checkAuthStatusAsync();
    
    _initialized = true;
  }
  
  static Future<void> _checkAuthStatusAsync() async {
    // Verificamos el estado de autenticación sin bloquear la inicialización
    try {
      await _getIt<AuthStore>().checkLoginStatus();
    } catch (e) {
      // Manejo silencioso de errores durante la inicialización
      print('Error al verificar estado de autenticación: $e');
    }
  }
  
  static void dispose() {
    if (!_initialized) return;
    
    // No necesitamos limpiar SharedPreferences ya que se usa en otros lugares
    
    if (_getIt.isRegistered<AuthRepository>()) {
      _getIt.unregister<AuthRepository>();
    }
    
    if (_getIt.isRegistered<FormStore>()) {
      final formStore = _getIt<FormStore>();
      formStore.dispose(); // Asegurarnos de limpiar las reacciones MobX
      _getIt.unregister<FormStore>();
    }
    
    if (_getIt.isRegistered<AuthStore>()) {
      _getIt.unregister<AuthStore>();
    }
    
    _initialized = false;
  }
} 