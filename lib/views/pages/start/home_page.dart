import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/views/widgets/card_popular_room.dart';

import '../../widgets/card_recomendation_room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultpd, vertical: defaultpd * 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Salas Populares',
            style: TextStyle(
                color: bgColor,
                fontSize: defaultpd * 1.5,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(defaultpd),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(right: defaultpd),
                    child: CardPopularRoom(size: size),
                  );
                }),
          ),
          CardRecomendationRoom(size: size),
          Container()
        ]),
      ),
    );
  }
}
