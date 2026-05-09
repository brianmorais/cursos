extension StringExtension on String? {
  bool isEmailValid() {
    final RegExp regExp =
        RegExp(r"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
    return regExp.hasMatch(this!);
  }
}
