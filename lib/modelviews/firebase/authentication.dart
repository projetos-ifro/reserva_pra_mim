// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

//Login
class LoginEmaileSenha {
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  TextEditingController get controladorEmail => _controladorEmail;

  TextEditingController get controladorSenha => _controladorSenha;

  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
  }

  Future<void> login(BuildContext context) async {
    try {
      final credencial = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controladorEmail.text, password: _controladorSenha.text);
      _controladorEmail.clear();
      _controladorSenha.clear();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> esqueceuSenha(BuildContext context) async {
    final emailAddress = _controladorEmail.text;
    if (emailAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira seu e-mail')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('E-mail enviado'),
          content: const Text('Verifique seu e-mail para redefinir sua senha.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('\n');
      print(e.message);
      print(e.code);
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Senha incorreta')));
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Nenhuma conta com este e-mail foi encontrada. Considere se registrar.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Erro ao solicitar a redefinição de senha')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro desconhecido')),
      );
    }
  }
}

//Registro
class RegisterEmailSenha {
  final TextEditingController _controladorNome = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();
  final TextEditingController _controladorConfirmarSenha =
      TextEditingController();

  TextEditingController get controladorNome => _controladorNome;
  TextEditingController get controladorEmail => _controladorEmail;
  TextEditingController get controladorSenha => _controladorSenha;
  TextEditingController get controladorConfirmarSenha =>
      _controladorConfirmarSenha;

  String? validateEmail(String? value) {
    final value = _controladorEmail.text;

    if (value == null || value.isEmpty) {
      return 'O campo de email é obrigatório';
    }

    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Insira um email válido';
    }

    return null;
  }

  String? validatePasswordMatch(String? value) {
    final senha = _controladorSenha.text;
    final confirmarSenha = _controladorConfirmarSenha.text;

    if (senha != confirmarSenha) {
      return 'As senhas não coincidem';
    }

    return null;
  }

  void dispose() {
    _controladorEmail.dispose();
    _controladorSenha.dispose();
    _controladorNome.dispose();
    _controladorConfirmarSenha.dispose();
  }

  Future<void> updateUserName(String displayName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await user.updateDisplayName(displayName);
        await user.reload();
      } catch (e) {
        print('Erro ao atualizar o nome do usuário: $e');
      }
    }
  }

  Future<void> register(BuildContext context) async {
    final validationError = validateEmail(_controladorEmail.text);
    if (validationError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(validationError)),
      );
      return;
    }
    final passwordMatchError =
        validatePasswordMatch(_controladorConfirmarSenha.text);
    if (passwordMatchError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordMatchError)),
      );
      return;
    }
    try {
      final credencial = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controladorEmail.text, password: _controladorSenha.text);

      await updateUserName(_controladorNome.text);
      _controladorEmail.clear();
      _controladorSenha.clear();
      _controladorConfirmarSenha.clear();
      _controladorNome.clear();

      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Já existe uma conta com esse e-mail.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Falha ao registrar')),
      );
    }
  }
}

//Sair
class Logout {
  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } catch (e) {}
  }
}

class UserController extends GetxController {
  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
  }
}

Future<void> atualizarUsuario(context, String email, String displayName) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    user.updateDisplayName(displayName);
    user.updateEmail(email);
  }
}
