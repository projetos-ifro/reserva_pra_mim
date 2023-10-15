import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class Card_home_search extends StatefulWidget {
  final Size size;

  Card_home_search({Key? key, required this.size}) : super(key: key);

  @override
  State<Card_home_search> createState() => _Card_home_searchState();
}

// ignore: camel_case_types
class _Card_home_searchState extends State<Card_home_search> {
  TextEditingController _textHomeSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: defaultpd, vertical: defaultpd * 2),
      padding: EdgeInsets.all(defaultpd),
      width: widget.size.width * 1,
      height: widget.size.height * 0.20,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(defaultpd)),
      child: Column(children: [
        Text(
          'O que vamos alugar hoje?',
          style: TextStyle(
            color: bgColor,
            fontWeight: FontWeight.bold,
            fontSize: defaultpd,
          ),
        ),
        SizedBox(
          height: defaultpd * 2,
        ),
        TextFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultpd),
              prefixIcon: const Icon(
                Icons.search,
                color: bgColor,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: bgColor),
                  borderRadius: BorderRadius.circular(defaultpd * 5)),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: bgColor),
                  borderRadius: BorderRadius.circular(defaultpd * 5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: bgColor),
                  borderRadius: BorderRadius.circular(defaultpd * 5))),
          controller: _textHomeSearch,
        )
      ]),
    );
  }
}
