import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../modelviews/firebase/authentication.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future:
      Autenticacao().isUserAdmin(FirebaseAuth.instance.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(
            backgroundColor: const Color(0xFF006060),
            title: const Text(
              'Reserva Pra Mim',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true, iconTheme: IconThemeData(color: Colors.white)

          );
        } else if (snapshot.hasError) {
          return AppBar(
            backgroundColor: Colors.red,
            title: const Text('Erro ao verificar permissões'),
            centerTitle: true,
          );
        } else {
          final isAdmin = snapshot.data == true;

          return AppBar(
            backgroundColor: const Color(0xFF006060),
            title: const Text(
              'Reserva Pra Mim',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  Autenticacao().logout(context);
                },
              ),
            ],
          );
        }
      },
    );
  }
}
