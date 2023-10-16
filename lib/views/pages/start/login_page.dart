import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modelviews/firebase/authentication.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController controladorEmail = TextEditingController();
  final TextEditingController controladorSenha = TextEditingController();
  final Autenticacao autenticacao = Autenticacao();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF097878),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 80, 50, 80),
                child: SizedBox(
                  child:
                  Image.asset('assets/logo.png', width: 100, height: 100),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Column(
                      children: <Widget>[
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () => autenticacao.resetPassword(
                                  context, controladorEmail.text),
                              child: const Text('Esqueceu a senha?',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 14)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/logon');
                              },
                              child: const Text('Registre-se',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                 await autenticacao.loginUser(
                                  context,
                                  controladorEmail.text,
                                  controladorSenha.text,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF006060),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset('assets/google.png',
                              width: 40, height: 40),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
