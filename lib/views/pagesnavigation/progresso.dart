import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/modelviews/reserve/reserve_controller.dart';
import 'package:reserva_pra_mim/views/widgets/card_recomendation_room.dart';
import 'package:reserva_pra_mim/views/widgets/card_reserve_progress.dart';

class ProgessoPage extends StatefulWidget {
  const ProgessoPage({super.key});

  @override
  State<ProgessoPage> createState() => _ProgessoPageState();
}

class _ProgessoPageState extends State<ProgessoPage> {
  final controlReserve = Get.find<Control_reserve>();
  var reserves = <Reserve>[].obs;

  @override
  void initState() {
    super.initState();
    loadReserves();
  }

  Future<void> loadReserves() async {
    final loadedReserves = await controlReserve.getActiveUserReservations();
    reserves.assignAll(loadedReserves);
  }

  Future<Room?> getRoom(Reserve reserve) async {
    try {
      return await reserve.getRoom();
    } catch (e) {
      print('Erro ao obter a sala da reserva: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: defaultpd,
          vertical: defaultpd * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recomendações',
              style: TextStyle(
                color: bgColor,
                fontSize: defaultpd * 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 1000, // Defina uma altura inicial desejada
              child: Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(defaultpd),
                  itemCount: reserves.length,
                  itemBuilder: (BuildContext context, int index) {
                    final room = getRoom(reserves[index]);
                    return Padding(
                      padding: EdgeInsets.only(bottom: defaultpd),
                      child: CardReserveProgress(
                          size: size, reserve: reserves[index], room: room),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
