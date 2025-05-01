import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _FormStore() {
    _disposers = [
      reaction((_) => userEmail, validateUserEmail, fireImmediately: false),
      reaction((_) => password, validatePassword, fireImmediately: false),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String userEmail = '';

  @observable
  String password = '';

  @observable
  bool success = false;

  @observable
  String? userEmailError;

  @observable
  String? passwordError;

  @observable
  bool hasAttemptedSubmit = false;

  // Caching computed values
  @computed
  bool get emailValid => userEmailError == null && userEmail.isNotEmpty;
  
  @computed
  bool get passwordValid => passwordError == null && password.isNotEmpty;

  @computed
  bool get canLogin {
    if (hasAttemptedSubmit) {
      return emailValid && passwordValid;
    }
    return userEmail.isNotEmpty && password.isNotEmpty;
  }

  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    if (userEmail == value) return; // Prevenir actualizaciones innecesarias
    userEmail = value;
    if (hasAttemptedSubmit || value.isNotEmpty) {
      validateUserEmail(value);
    }
  }

  @action
  void setPassword(String value) {
    if (password == value) return; // Prevenir actualizaciones innecesarias
    password = value;
    if (hasAttemptedSubmit || value.isNotEmpty) {
      validatePassword(value);
    }
  }

  @action
  void trySubmit() {
    hasAttemptedSubmit = true;
    validateAll();
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      userEmailError = 'error_email_empty';
    } else if (!isEmail(value)) {
      userEmailError = 'error_email_format';
    } else {
      userEmailError = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = 'error_password_empty';
    } else if (value.length < 6) {
      passwordError = 'error_password_short';
    } else {
      passwordError = null;
    }
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateUserEmail(userEmail);
    validatePassword(password);
  }
  
  // Reset form state
  @action
  void reset() {
    userEmail = '';
    password = '';
    userEmailError = null;
    passwordError = null;
    hasAttemptedSubmit = false;
    success = false;
  }
} 