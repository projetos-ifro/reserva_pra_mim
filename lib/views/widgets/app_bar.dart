import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modelviews/firebase/authentication.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
            final logoutController = Autenticacao().logout(context);
            //logoutController.logout(context);
          },
        ),
      ],
    );
  }
}
