import 'package:flutter/material.dart';

import '../pages/menusDrawer/adminsPage.dart';
import '../pages/menusDrawer/meuPerfil.dart';
import '../pages/salas/create_room.dart';

class CustomDrawer extends StatelessWidget {
  final bool isAdmin;
  final String userName;
  final String userEmail;

  const CustomDrawer(this.isAdmin, this.userName, this.userEmail, {super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFFE7E7E7),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Color(0xFF007878),
              height: 120,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 35, 10, 20),
                child: Row(
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 32,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 10), // Espaço entre o ícone e o texto
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(userEmail, style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Meu Perfil'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MeuPerfilPage()));
              },
            ),
            if (isAdmin)
              ListTile(
                title: const Text('Opções de Administrador',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            if (isAdmin)
              ListTile(
                contentPadding: EdgeInsets.only(
                    left: 32), // Ajuste o valor conforme necessário
                title: const Text('Adicionar Sala'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Create_room()));
                },
              ),
            if (isAdmin)
              ListTile(
                contentPadding: EdgeInsets.only(
                    left: 32), // Ajuste o valor conforme necessário
                title: const Text('Admins'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AdminPage()));
                },
              ),
          ],
        ),
      ),
    );
  }
}
