import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String? email;

  @observable
  String? password;

  @observable
  bool loading = false;

  @observable
  String error = '';

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  Future<void> _login() async {
    loading = true;

    try {
      final user = await UserRepository().loginWithEmail(email!, password!);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e.toString();
    }

    loading = false;
  }

  @computed
  bool get emailValid => email != null && email.isEmailValid();

  @computed
  bool get passwordValid => password != null && password!.length >= 6;

  @computed
  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else {
      return 'E-mail inválido';
    }
  }

  @computed
  String? get passwordError {
    if (password == null || passwordValid) {
      return null;
    } else {
      return 'Senha inválida';
    }
  }

  @computed
  bool get isFormValid => emailValid && passwordValid;

  @computed
  VoidCallback? get logInPressed => (isFormValid && !loading) ? _login : null;
}
