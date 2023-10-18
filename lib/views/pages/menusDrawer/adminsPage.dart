import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../modelviews/firebase/authentication.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final Autenticacao _autenticacao = Autenticacao();

  List<String> _adminIds = [];
  List<Map<String, dynamic>> _adminInfo = [];

  @override
  void initState() {
    super.initState();
    loadAdmins();
  }

  Future<void> loadAdmins() async {
    final adminData = await _autenticacao.loadAdminIds();
    setState(() {
      _adminInfo = adminData; // Preencha _adminInfo com os dados retornados
      _adminIds = adminData.map((admin) => admin['id'] as String).toList(); // Extraia os IDs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Administradores'),
      ),
      body: FutureBuilder(
        future: loadAdmins(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final adminIds = snapshot.data as List<Map<String, dynamic>>;

            return ListView.builder(
              itemCount: adminIds.length,
              itemBuilder: (context, index) {
                final adminId = adminIds[index]['id'] as String;
                final userInfo = adminIds[index];

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Coluna esquerda
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40, // Substitua pela imagem do usuário
                          ),
                          Icon(
                            Icons.person, // Substitua pelo ícone apropriado
                            color: Colors.grey, // Cor do ícone
                            size: 40, // Tamanho do ícone
                          ),
                        ],
                      ),
                      SizedBox(width: 16), // Espaço entre as colunas
                      // Coluna direita
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (userInfo != null) ...[
                            Text(
                              userInfo['name'] as String? ?? 'Nome não disponível',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              userInfo['email'] as String? ?? 'Email não disponível',
                              style: TextStyle(fontSize: 14),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Admin',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os administradores: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
