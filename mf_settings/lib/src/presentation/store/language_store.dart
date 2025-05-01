import 'package:shared_dependencies/shared_dependencies.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String PREF_LANGUAGE_CODE = "language_code";
  
  final SharedPreferences _sharedPreferences;
  
  _LanguageStore(this._sharedPreferences) {
    _init();
  }
  
  Future<void> _init() async {
    languageCode = _sharedPreferences.getString(PREF_LANGUAGE_CODE) ?? 'es';
  }
  
  @observable
  String languageCode = 'es';
  
  @computed
  bool get isEnglish => languageCode == 'en';
  
  @computed
  bool get isSpanish => languageCode == 'es';
  
  @action
  Future<void> setLanguage(String code) async {
    languageCode = code;
    await _sharedPreferences.setString(PREF_LANGUAGE_CODE, code);
    
    // Notify other modules about the language change
    GlobalEventBus.instance.fire(LanguageChangedEvent(code));
  }
  
  @action
  Future<void> toggleLanguage() async {
    if (isEnglish) {
      await setLanguage('es');
    } else {
      await setLanguage('en');
    }
  }
} 