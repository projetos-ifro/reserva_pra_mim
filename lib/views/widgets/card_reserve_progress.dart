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
    required this.room,
  });

  final Size size;
  final Future<Room?> room;
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
            Get.toNamed('/reserveDetai', arguments: widget.reserve);
          },
          child: Container(
            padding: EdgeInsets.all(defaultpd / 2),
            height: widget.size.height * .15,
            width: widget.size.width,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(defaultpd)),
            child: Padding(
              padding: EdgeInsets.all(defaultpd / 2),
              child: Row(children: [
                Container(
                  height: widget.size.height * .5,
                  width: widget.size.height * .12,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(defaultpd)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultpd / 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widget.size.width * 0.45,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'teste',
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
                        'Capacidade ${widget.reserve.reservedRoom}',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      Container(
                          width: widget.size.width * .45,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'R\$ ${widget.reserve.reservedRoom} / Hr',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
              ]),
            ),
          ),
        )
      ],
    );
  }
}
