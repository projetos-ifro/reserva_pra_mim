import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/reserve/reserve_controller.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';
import '../../modelviews/constants.dart';

class CardReserveProgress extends StatefulWidget {
  CardReserveProgress({
    super.key,
    required this.size,
    required this.reserve,
    required this.roomid,
  });

  final Size size;
  final String roomid;
  final Reserve reserve;

  @override
  State<CardReserveProgress> createState() => _CardReserveProgressState();
}

class _CardReserveProgressState extends State<CardReserveProgress> {
  final controlRoom = Get.find<ControlRoom>();
  final controlReserve = Get.find<Control_reserve>();
  Room? room;
  double? price;

  @override
  void initState() {
    super.initState();

    loadRoomData();
    setState(() {});
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
            Get.toNamed('/detailReserved', arguments: widget.reserve);
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Há ${controlReserve.calculateTimePassed(widget.reserve.bookingDateTime)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Container(
                          width: widget.size.width * 0.50,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'R\$ ${room!.pricePerHour} / Hr',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
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
