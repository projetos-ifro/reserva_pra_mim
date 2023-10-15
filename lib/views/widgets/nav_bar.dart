import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return const GNav(
        activeColor: Colors.white,
        color: Colors.white,
        backgroundColor: bgColor,
        gap: 8,
        tabs: [
          GButton(
            icon: FontAwesomeIcons.ticket,
            text: 'Progresso',
          ),
          GButton(
            icon: FontAwesomeIcons.house,
            text: 'Início',
          ),
          GButton(
            icon: FontAwesomeIcons.listCheck,
            text: 'Search',
          ),
        ]);
  }
}
