import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignupScreen extends StatelessWidget {
  final SignupStore signupStore = SignupStore();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Observer(
                      builder: (_) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ErrorBox(
                          message: signupStore.error,
                        ),
                      ),
                    ),
                    FieldTitle(
                      title: 'Apelido',
                      subtitle: 'Como aparecerá em seus anúmcios',
                    ),
                    Observer(
                      builder: (_) => TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: João S.',
                          isDense: true,
                          errorText: signupStore.nemeError,
                        ),
                        onChanged: signupStore.setName,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'E-mail',
                      subtitle: 'Enviaremos um e-mail de confirmação',
                    ),
                    Observer(
                      builder: (_) => TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: joao@example.com',
                          isDense: true,
                          errorText: signupStore.emailError,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: signupStore.setEmail,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Celular',
                      subtitle: 'Proteja sua conta',
                    ),
                    Observer(
                      builder: (_) => TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: (99) 99999-9999',
                          isDense: true,
                          errorText: signupStore.phoneError,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        onChanged: signupStore.setPhone,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Senha',
                      subtitle: 'Use letras, números e caracteres especiais',
                    ),
                    Observer(
                      builder: (_) => TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass1Error,
                        ),
                        obscureText: true,
                        onChanged: signupStore.setPass1,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FieldTitle(
                      title: 'Confirmar Senha',
                      subtitle: 'Repita a senha',
                    ),
                    Observer(
                      builder: (_) => TextField(
                        enabled: !signupStore.loading,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass2Error,
                        ),
                        obscureText: true,
                        onChanged: signupStore.setPass2,
                      ),
                    ),
                    Observer(
                      builder: (_) => Container(
                        margin: const EdgeInsets.only(bottom: 12, top: 20),
                        height: 40,
                        child: ElevatedButton(
                          onPressed: signupStore.signUpPressed,
                          child: signupStore.loading
                              ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                    Colors.white,
                                  ),
                                )
                              : const Text(
                                  'CADASTRAR',
                                  style: TextStyle(color: Colors.white),
                                ),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double?>(0),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.orange.withOpacity(0.5);
                                } else {
                                  return Colors.orange;
                                }
                              },
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder?>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Já tem uma conta? ',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: const Text(
                              'Entrar',
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.purple,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
