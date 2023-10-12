import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modelviews/firebase/authetication.dart';

class LoginPage extends StatelessWidget {
  final LoginEmaileSenha loginController = Get.find();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFF097878), // Cor de fundo #097878
          height: MediaQuery.of(context).size.height, // Define a altura como a altura da tela
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 80, 50, 80),
                child: SizedBox(
                  child: Image.asset('assets/logo.png', width: 100, height: 100),
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
                          controller: loginController.controladorEmail,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 10),
                    
                        TextField(
                          controller: loginController.controladorSenha,
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 30),
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/register');
                              },
                              child: const Text('Registre-se',
                                  style: TextStyle(color: Colors.blue, fontSize: 16)),
                            ),
                            SizedBox(width: 15,),
                    
                            ElevatedButton(
                              onPressed: () => loginController.login(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color(0xFF006060),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 18),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),

                        // Ícone do Google (adapte para o ícone desejado)
                        GestureDetector(
                          onTap: () {
                            // Implemente a autenticação com o Google
                          },
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
