import 'package:get_it/get_it.dart';
import 'package:mf_settings/src/presentation/store/language_store.dart';
import 'package:mf_settings/src/presentation/store/theme_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModule {
  static final GetIt _getIt = GetIt.instance;
  
  static Future<void> init() async {
    // Obtenemos la instancia de SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    
    // Registramos SharedPreferences si no está registrado
    if (!_getIt.isRegistered<SharedPreferences>()) {
      _getIt.registerSingleton<SharedPreferences>(sharedPreferences);
    }
    
    // Registramos los stores
    _getIt.registerLazySingleton<ThemeStore>(
      () => ThemeStore(_getIt<SharedPreferences>()),
    );
    
    _getIt.registerLazySingleton<LanguageStore>(
      () => LanguageStore(_getIt<SharedPreferences>()),
    );
  }
  
  static void dispose() {
    // No necesitamos limpiar SharedPreferences ya que se usa en otros lugares
    
    if (_getIt.isRegistered<ThemeStore>()) {
      _getIt.unregister<ThemeStore>();
    }
    
    if (_getIt.isRegistered<LanguageStore>()) {
      _getIt.unregister<LanguageStore>();
    }
  }
} 