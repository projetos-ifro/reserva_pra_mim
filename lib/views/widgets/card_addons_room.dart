import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class Card_addons_room extends StatelessWidget {
  const Card_addons_room({super.key, required this.size, required this.text});

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size.width * 0.15,
      height: size.height * 0.03,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(defaultpd)),
      child: Text(
        text,
        style: TextStyle(
            color: bgColor,
            fontWeight: FontWeight.bold,
            fontSize: defaultpd / 1.5),
      ),
    );
  }
}
