import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class MyNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  MyNavigationBar({required this.selectedIndex, required this.onTabChange});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
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
      onTabChange: widget.onTabChange,
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
      ],
      selectedIndex: widget.selectedIndex,
    );
  }
}
