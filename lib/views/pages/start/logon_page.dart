import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modelviews/firebase/authentication.dart';

class LogonPage extends StatelessWidget {
  final TextEditingController controladorNome = TextEditingController();
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final TextEditingController controladorConfirmarSenha =
      TextEditingController();

  final Autenticacao autenticacao = Autenticacao();

  String? _passwordConfirmationError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
          child: Column(
            children: <Widget>[
              TextField(
                controller: controladorNome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controladorEmail,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controladorSenha,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controladorConfirmarSenha,
                decoration: InputDecoration(
                  labelText: 'Confirmar Senha',
                  errorText: _passwordConfirmationError,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: const Text('Já tenho conta',
                        style: TextStyle(color: Colors.blue, fontSize: 16)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await autenticacao.createUser(
                        context,
                        controladorNome.text,
                        controladorEmail.text,
                        controladorSenha.text,
                        controladorConfirmarSenha.text,
                        false, // Você precisa decidir se o usuário é admin
                      );

                      if (result != null) {
                        // Registro bem-sucedido, faça algo aqui
                        print('Registro bem-sucedido');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006060),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Registrar',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () {},
                child: Image.asset('assets/google.png', width: 40, height: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
