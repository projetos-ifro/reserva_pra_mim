// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email inválido')),
        );
        return null;
      }

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('As senhas não coincidem')),
        );
        return null;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao criar a conta')),
      );
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
      if (kDebugMode) {
        print('Erro ao cadastrar o usuário no banco de dados: $e');
      }
    }
  }

  Future<void> updateUser(
      BuildContext context, String name, String email) async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await currentUser.updateDisplayName(name);

        if (email != currentUser.email) {
          final emailVerified = currentUser.emailVerified;
          if (!emailVerified) {
            await currentUser.sendEmailVerification();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Email de Verificação Enviado'),
                  content: const Text(
                      'Um email de verificação foi enviado para o novo endereço de email. Por favor, verifique seu email.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            await currentUser.updateEmail(email);
            await _db.collection("users").doc(currentUser.uid).update({
              'name': name,
              'email': email,
            });
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao atualizar os dados: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar os dados: $e'),
        ),
      );
    }
  }

  Future<bool> loginUser(
      BuildContext context, String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login efetuado com sucesso')),
        );
        Get.offAllNamed('/home');
        return true;
      }
      return false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login ou senha incorretos')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Opa, algo de errado aconteceu...')),
        );
      }
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro desconhecido')),
      );
      return false;
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deslogado com sucesso')),
      );
      Get.offAllNamed('/login'); // Redireciona para a tela de login
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao deslogar')),
      );
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
        return isAdmin == true;
      }

      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao verificar se o usuário é admin: $e');
      }
      return false;
    }
  }

  Future<List<String>> loadAdminIds() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final adminsQuery = await _db
            .collection('users')
            .where('isAdmin', isEqualTo: true)
            .get();

        final adminDocs = adminsQuery.docs;
        final adminIds = adminDocs.map((adminDoc) => adminDoc.id).toList();

        return adminIds;
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar os IDs dos administradores: $e');
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> loadUserInfo(String userId) async {
    try {
      final userDoc = await _db.collection('users').doc(userId).get();
      return userDoc.data() as Map<String, dynamic>? ?? {};
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao carregar informações do usuário: $e');
      }
      return {};
    }
  }
}
