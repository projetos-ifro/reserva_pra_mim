import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class My_nav_bar extends StatefulWidget {
  const My_nav_bar({super.key});

  @override
  State<My_nav_bar> createState() => _My_nav_barState();
}

class _My_nav_barState extends State<My_nav_bar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
        tabMargin: EdgeInsets.all(defaultpd / 2),
        iconSize: defaultpd,
        activeColor: bgColor,
        color: Colors.white,
        backgroundColor: bgColor,
        tabBackgroundColor: Colors.white,
        gap: 8,
        onTabChange: (index) {
          print(index);
        },
        tabs: const [
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
            text: 'Histórico',
          ),
        ]);
  }
}
