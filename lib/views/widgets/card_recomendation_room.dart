import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../modelviews/constants.dart';

class CardRecomendationRoom extends StatelessWidget {
  const CardRecomendationRoom({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nome da Sala',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: defaultpd,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.white,
                            size: defaultpd,
                          )
                        ],
                      ),
                      const Text(
                        'Endereço da sala',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      Container(
                          width: size.width * .5,
                          alignment: Alignment.bottomRight,
                          child: const Text(
                            'R\$15,00 / Hr',
                            style: TextStyle(
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
