import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/views/pages/salas/create_room.dart';
import 'package:reserva_pra_mim/views/widgets/card_home_search.dart';
import 'package:reserva_pra_mim/views/widgets/card_popular_room.dart';
import 'package:reserva_pra_mim/views/widgets/nav_bar.dart';

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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: defaultpd,
              vertical: defaultpd * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Create_room()));
                    },
                    child: const Text('Teste')),
                Card_home_search(
                  size: size,
                ),
                Text(
                  'Salas Populares',
                  style: TextStyle(
                    color: bgColor,
                    fontSize: defaultpd * 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: defaultpd / 2),
                SizedBox(
                  height:
                      size.height * 0.3, // Defina uma altura inicial desejada
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(defaultpd),
                    itemCount: 4, // Defina o número de itens dinamicamente
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(right: defaultpd),
                        child: CardPopularRoom(size: size),
                      );
                    },
                  ),
                ),
                Text(
                  'Recomendações',
                  style: TextStyle(
                    color: bgColor,
                    fontSize: defaultpd * 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 2000, // Defina uma altura inicial desejada
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(defaultpd),
                    itemCount: 4, // Defina o número de itens dinamicamente
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: defaultpd),
                        child: CardRecomendationRoom(size: size),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const My_nav_bar(),
    );
  }
}
