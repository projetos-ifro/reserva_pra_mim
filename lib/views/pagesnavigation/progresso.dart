import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/modelviews/reserve/reserve_controller.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';
import 'package:reserva_pra_mim/views/widgets/card_reserve_progress.dart';

class ProgressoPage extends StatefulWidget {
  const ProgressoPage({super.key});

  @override
  State<ProgressoPage> createState() => _ProgessoPageState();
}

class _ProgessoPageState extends State<ProgressoPage> {
  final controlReserve = Get.find<Control_reserve>();
  final controlRoom = ControlRoom();
  var reserves = <Reserve>[].obs;
  var rooms = <Reserve>[].obs;

  @override
  void initState() {
    super.initState();
    loadReserves();
  }

  Future<void> loadReserves() async {
    final loadedReserves = await controlReserve.getActiveUserReservations();

    reserves.assignAll(loadedReserves);
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
            ElevatedButton(
                onPressed: () {
                  print('Sala: ');
                },
                child: Text('Clica')),
            SizedBox(
              height: 500,
              child: Obx(
                () => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(defaultpd),
                  itemCount: reserves.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: defaultpd),
                      child: CardReserveProgress(
                        size: size,
                        reserve: reserves[index],
                      ),
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
