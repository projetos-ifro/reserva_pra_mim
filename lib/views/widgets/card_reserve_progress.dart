import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';
import '../../modelviews/constants.dart';

class CardReserveProgress extends StatefulWidget {
  const CardReserveProgress({
    super.key,
    required this.size,
    required this.reserve,
    this.room,
  });

  final Size size;
  final Room? room;
  final Reserve reserve;

  @override
  State<CardReserveProgress> createState() => _CardReserveProgressState();
}

class _CardReserveProgressState extends State<CardReserveProgress> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/reserveDetail', arguments: widget.reserve);
          },
          child: Container(
            padding: EdgeInsets.all(defaultpd / 2),
            height: widget.size.height * .15,
            width: widget.size.width,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(defaultpd)),
            child: Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: widget.size.width * 0.50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.room?.name ?? 'Nome não disponível',
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
                  Text(
                    'Capacidade: ${widget.room?.capacity}',
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  Container(
                      width: widget.size.width * .45,
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'R\$ ${widget.room?.pricePerHour} / Hr',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}
