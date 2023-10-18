import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../modelviews/firebase/authentication.dart';

class MeuPerfilPage extends StatefulWidget {
  @override
  _MeuPerfilPageState createState() => _MeuPerfilPageState();
}

class _MeuPerfilPageState extends State<MeuPerfilPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      nameController.text = currentUser.displayName ?? "";
      emailController.text = currentUser.email ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF184848),
          title: const Text('Meu Perfil', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white)
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey, // Cor de fundo da imagem
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white, // Cor do ícone
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Autenticacao().updateUser(context,
                    nameController.text, emailController.text);
              },
              child: Text("Salvar"),
            ),
          ],
        ),
      ),
    );
  }
}
