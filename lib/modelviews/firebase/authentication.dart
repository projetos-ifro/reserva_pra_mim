import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Autenticacao {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUser(BuildContext context, String name, String email,
      String password, String confirmPassword, bool isAdmin) async {
    try {
      final emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

      if (!emailRegex.hasMatch(email)) {
        print('Email inválido');
        return null;
      }

      if (password != confirmPassword) {
        print('As senhas não coincidem');
        return null;
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(name);
        await user.reload();
        await saveUserRegister(user.uid, name, email, isAdmin);
        Get.offAllNamed('/login');
      }

      return user;
    } catch (e) {
      print('Erro ao criar a conta: $e');
      return null;
    }
  }

  Future<void> saveUserRegister(
      String userId, String name, String email, bool isAdmin) async {
    try {
      await _db.collection("users").doc(userId).set({
        'name': name,
        'email': email,
        'isAdmin': false,
      });
    } catch (e) {
      print('Erro ao cadastrar o usuário no banco de dados: $e');
    }
  }

  Future<void> updateUser(String name, String email) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);

        if (email != currentUser.email) {
          await currentUser.updateEmail(email);
        }
      }
    } catch (e) {
      print('Erro ao atualizar os dados: $e');
    }
  }

  Future<bool> loginUser(BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        print('Login efetuado com sucesso');
        Get.offAllNamed('/home');
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'auth/wrong-password') {
        print('Login ou senha incorretos');
      } else {
        print('Opa, algo de errado aconteceu...');
      }
      return false;
    } catch (e) {
      print('Erro: $e');
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print('Logout efetuado com sucesso');
      Get.offAllNamed('/login'); // Redireciona para a tela de login
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

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
      if (e.code == 'user-not-found') {
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

  Future<bool> isUserAdmin(String userId) async {
    try {
      final DocumentSnapshot userDoc =
          await _db.collection("users").doc(userId).get();

      if (userDoc.exists) {
        final bool isAdmin = userDoc['isAdmin'];
        return isAdmin;
      }

      return false; // Usuário não encontrado no Firestore.
    } catch (e) {
      print('Erro ao verificar se o usuário é admin: $e');
      return false;
    }
  }
}
