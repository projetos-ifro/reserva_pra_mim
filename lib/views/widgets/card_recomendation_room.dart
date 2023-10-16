import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/room.dart';
import '../../modelviews/constants.dart';

class CardRecomendationRoom extends StatelessWidget {
  const CardRecomendationRoom({
    super.key,
    required this.size,
    required this.room,
  });

  final Size size;
  final Room room;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/detail', arguments: room);
          },
          child: Container(
            padding: EdgeInsets.all(defaultpd / 2),
            height: size.height * .15,
            width: size.width,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(defaultpd)),
            child: Padding(
              padding: EdgeInsets.all(defaultpd / 2),
              child: Row(children: [
                Container(
                  height: size.height * .5,
                  width: size.height * .12,
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
                        width: size.width * 0.5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              room.name,
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
                        'Capacidade ${room.capacity}',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      Container(
                          width: size.width * .5,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'R\$ ${room.pricePerHour} / Hr',
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
