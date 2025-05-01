import 'package:shared_dependencies/shared_dependencies.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  static const String PREF_IS_DARK_MODE = "is_dark_mode";
  
  final SharedPreferences _sharedPreferences;
  
  _ThemeStore(this._sharedPreferences) {
    _init();
  }
  
  Future<void> _init() async {
    isDarkMode = _sharedPreferences.getBool(PREF_IS_DARK_MODE) ?? false;
  }
  
  @observable
  bool isDarkMode = false;
  
  @action
  Future<void> setDarkMode(bool value) async {
    isDarkMode = value;
    await _sharedPreferences.setBool(PREF_IS_DARK_MODE, value);
    
    // Notify other modules about the theme change
    GlobalEventBus.instance.fire(ThemeChangedEvent(value));
  }
  
  @action
  Future<void> toggleTheme() async {
    await setDarkMode(!isDarkMode);
  }
} 