import 'package:flutter/material.dart';
import '../../modelviews/constants.dart';

class CardRecomendationRoom extends StatelessWidget {
  const CardRecomendationRoom({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recomendações',
            style: TextStyle(
                fontSize: defaultpd * 1.5,
                fontWeight: FontWeight.bold,
                color: bgColor),
          ),
          SizedBox(
            height: defaultpd / 2,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: size.height * .15,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(defaultpd)),
              child: Padding(
                padding: EdgeInsets.all(defaultpd / 1.5),
                child: Row(children: [
                  Container(
                    height: size.height * .5,
                    width: size.height * .15,
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
                            const Icon(
                              Icons.abc,
                              color: Colors.white,
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
                          width: size.width * .55,
                          alignment: Alignment.bottomRight,
                          child: const Text(
                            'R\$ 15,00 / Hr',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
