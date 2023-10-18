import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';

import '../../modelviews/constants.dart';
import '../../modelviews/historico/historico_controller.dart';
import '../../modelviews/reserve/reserve_controller.dart';
import '../../modelviews/room/room_cotroller.dart'; // Certifique-se de importar o controlador correto

class CardReserveFinalizada extends StatefulWidget {
  CardReserveFinalizada({
    Key? key,
    required this.size,
    required this.reserve,
    required this.roomid,

  });

  final Size size;
  final Reserve reserve;
  final String roomid;

  @override
  State<CardReserveFinalizada> createState() => _CardReserveFinalizadaState();
}

class _CardReserveFinalizadaState extends State<CardReserveFinalizada> {
  final controlReserve = Get.find<Historico_Controller>();
  final controlRoom = Get.find<ControlRoom>();
  Room? room;

  @override
  void initState() {
    super.initState();
    loadRoomData();
  }

  Future<void> loadRoomData() async {
    room = await controlRoom.getRoomById(widget.roomid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            // Adicione aqui a ação ao tocar no card, se necessário
          },
          child: Container(
            padding: EdgeInsets.all(defaultpd),
            height: widget.size.height * .15,
            width: widget.size.width,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(defaultpd)),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widget.size.width * 0.8,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          room?.name ?? 'Nome não disponível',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: defaultpd,
                              fontWeight: FontWeight.bold),
                        ),
                        FaIcon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                          size: defaultpd,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Capacidade: ${room?.capacity}',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reserva finalizada',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'R\$ ${Control_reserve().calcPrice(widget.reserve.bookingDateTime, room?.pricePerHour ?? 0).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}
