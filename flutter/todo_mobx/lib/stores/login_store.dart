import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool passwordVisible = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @action
  void togglePasswordVisibility() => passwordVisible = !passwordVisible;

  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    loggedIn = true;
  }

  @action
  void logout() {
    loggedIn = false;
    email = '';
    password = '';
  }

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isEmailValid =>
      RegExp(r"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*").hasMatch(email);

  @computed
  bool get isFormValid => isEmailValid && isPasswordValid && !loading;

  // @computed
  // Function? get loginPressed =>
  //     (isEmailValid && isPasswordValid && !loading) ? login : null;
}
