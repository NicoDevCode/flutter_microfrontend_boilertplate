// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LanguageStore on _LanguageStore, Store {
  Computed<bool>? _$isEnglishComputed;

  @override
  bool get isEnglish =>
      (_$isEnglishComputed ??= Computed<bool>(() => super.isEnglish,
              name: '_LanguageStore.isEnglish'))
          .value;
  Computed<bool>? _$isSpanishComputed;

  @override
  bool get isSpanish =>
      (_$isSpanishComputed ??= Computed<bool>(() => super.isSpanish,
              name: '_LanguageStore.isSpanish'))
          .value;

  late final _$languageCodeAtom =
      Atom(name: '_LanguageStore.languageCode', context: context);

  @override
  String get languageCode {
    _$languageCodeAtom.reportRead();
    return super.languageCode;
  }

  @override
  set languageCode(String value) {
    _$languageCodeAtom.reportWrite(value, super.languageCode, () {
      super.languageCode = value;
    });
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('_LanguageStore.setLanguage', context: context);

  @override
  Future<void> setLanguage(String code) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(code));
  }

  late final _$toggleLanguageAsyncAction =
      AsyncAction('_LanguageStore.toggleLanguage', context: context);

  @override
  Future<void> toggleLanguage() {
    return _$toggleLanguageAsyncAction.run(() => super.toggleLanguage());
  }

  @override
  String toString() {
    return '''
languageCode: ${languageCode},
isEnglish: ${isEnglish},
isSpanish: ${isSpanish}
    ''';
  }
}
