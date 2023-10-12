import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reserva_pra_mim/views/widgets/card_addons_room.dart';
import '../../modelviews/constants.dart';

class CardPopularRoom extends StatelessWidget {
  const CardPopularRoom({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: size.width * 0.80,
            height: size.height * 0.25,
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(defaultpd)),
            child: Container(
              padding: EdgeInsets.all(defaultpd),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * .10,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(defaultpd)),
                    ),
                    SizedBox(
                      height: defaultpd / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nome da Sala',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: defaultpd),
                        ),
                        Row(children: [
                          Text(
                            '(5.0)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: defaultpd),
                          ),
                          const FaIcon(
                            Icons.star_rounded,
                            color: Colors.white,
                          )
                        ])
                      ],
                    ),
                    Text(
                      'Endereço da sala',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: defaultpd / 1.5),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Card_addons_room(
                          size: size,
                          text: 'Wifi',
                        ),
                        SizedBox(
                          width: defaultpd / 2,
                        ),
                        Card_addons_room(
                          size: size,
                          text: 'Projetor',
                        ),
                        const Spacer(),
                        const Text(
                          'R\$15,00 / Hr',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
