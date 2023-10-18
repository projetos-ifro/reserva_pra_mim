import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String nome;
  final bool isAdmin;
  final String email;

  Usuario({
    required this.nome,
    required this.isAdmin,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'isAdmin': isAdmin,
      'email': email,
    };
  }

  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Usuario(
      nome: data['nome'],
      isAdmin: data['isAdmin'],
      email: data['email'],
    );
  }
}
