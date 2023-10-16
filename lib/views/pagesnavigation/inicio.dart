import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';
import 'package:reserva_pra_mim/views/pages/salas/create_room.dart';
import 'package:reserva_pra_mim/views/widgets/card_home_search.dart';
import 'package:reserva_pra_mim/views/widgets/card_popular_room.dart';
import '../widgets/card_recomendation_room.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  final controlRoom = Get.find<ControlRoom>();
  var rooms = <Room>[].obs;
  @override
  void initState() {
    super.initState();
    loadRooms();
  }

  Future<void> loadRooms() async {
    final loadedRooms = await controlRoom.getRooms();
    rooms.assignAll(loadedRooms);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                  child: Obx(
                    () => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(defaultpd),
                      itemCount: rooms
                          .where((room) => room
                              .isAvailable) // Filtra apenas as salas disponíveis
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: defaultpd),
                          child: CardRecomendationRoom(
                              size: size, room: rooms[index]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
