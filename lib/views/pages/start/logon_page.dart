import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modelviews/firebase/authentication.dart';

class LogonPage extends StatefulWidget {
  const LogonPage({Key? key}) : super(key: key);

  @override
  _LogonPageState createState() => _LogonPageState();
}

  class _LogonPageState extends State<LogonPage> {
  final RegisterEmailSenha registerController = Get.find();

  String? _passwordConfirmationError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20,40,20,30),
            child: Column(
              children: <Widget>[
                      TextField(
                        controller: registerController.controladorNome,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: registerController.controladorEmail,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: registerController.controladorSenha,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: registerController.controladorConfirmarSenha,
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
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 16)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final emailError = registerController.validateEmail(
                                  registerController.controladorEmail.text);
                              if (emailError == null &&
                                  _passwordConfirmationError == null) {
                                registerController.register(context);
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
                        child: Image.asset('assets/google.png',
                            width: 40, height: 40),
                      ),
                    ],
                  ),
                ),
            ),
    );
  }
}
