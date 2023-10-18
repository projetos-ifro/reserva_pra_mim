import 'package:flutter/material.dart';

import '../../../modelviews/firebase/authentication.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final Autenticacao _autenticacao = Autenticacao();
  List<String> _adminIds = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final adminIds = await _autenticacao.loadAdminIds();
    setState(() {
      _adminIds = adminIds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF184848),
        title: const Text(
          'Administradores',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        iconTheme: IconThemeData(
            color: Colors.white), // Define a cor do ícone como branca
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
        child: _adminIds.isNotEmpty
            ? ListView.builder(
                itemCount: _adminIds.length,
                itemBuilder: (context, index) {
                  final adminId = _adminIds[index];
                  return Column(
                    children: [
                      FutureBuilder<Map<String, dynamic>>(
                        future: _autenticacao.loadUserInfo(adminId),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text(""),
                            );
                          } else if (userSnapshot.hasData) {
                            final userInfo = userSnapshot.data ?? {};
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFC8C8C8), // Cor de fundo cinza
                                borderRadius: BorderRadius.circular(
                                    8.0), // Borda arredondada
                              ),
                              child: Row(
                                children: [
                                  // Coluna esquerda
                                  const Stack(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius:
                                            40, // Substitua pela imagem do usuário
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Icon(
                                          Icons
                                              .person, // Substitua pelo ícone apropriado
                                          color: Colors.grey, // Cor do ícone
                                          size: 40, // Tamanho do ícone
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      width: 16), // Espaço entre as colunas
                                  // Coluna direita
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userInfo['name'] as String? ??
                                            'Nome não disponível',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        userInfo['email'] as String? ??
                                            'Email não disponível',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'Admin',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          } else if (userSnapshot.hasError) {
                            return Text(
                                'Erro ao carregar informações do usuário: ${userSnapshot.error}');
                          } else {
                            return Container(); // Exibe um contêiner vazio enquanto carrega
                          }
                        },
                      ),
                      const SizedBox(
                          height: 16), // Espaçamento entre os usuários
                    ],
                  );
                },
              )
            : const Center(
                child: Text('Nenhum administrador disponível.'),
              ),
      ),
    );
  }
}
