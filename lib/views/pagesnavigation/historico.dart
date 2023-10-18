import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/reserve.dart';
import '../../modelviews/constants.dart';
import '../../modelviews/historico/historico_controller.dart';
import '../../modelviews/room/room_cotroller.dart';
import '../widgets/card_reserve_finalizados.dart';
import '../widgets/card_reserve_progress.dart';

class HistoricoPage extends StatefulWidget {
  final Historico_Controller viewModel;

  HistoricoPage({required this.viewModel});

  @override
  State<HistoricoPage> createState() => _HistoricoPageState();
}

class _HistoricoPageState extends State<HistoricoPage> {
  final controlReserve = Get.find<Historico_Controller>();
  final controlRoom = ControlRoom();
  var reserves = <Reserve>[].obs;

  @override
  void initState() {
    super.initState();
    loadReserves();
  }

  Future<void> loadReserves() async {
    final loadedReserves = await controlReserve.getCompletedUserReservations();
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
              'Reservas Finalizadas',
              style: TextStyle(
                color: bgColor,
                fontSize: defaultpd * 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
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
                      child: CardReserveFinalizada(
                        size: size,
                        reserve: reserves[index], roomid: reserves[index].reservedRoom,
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