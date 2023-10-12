import 'package:flutter/material.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: defaultpd, vertical: defaultpd * 2),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                'Salas Populares',
              ),
              SizedBox(
                height: defaultpd / 2,
              ),
              Container(
                width: size.width * 0.80,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(defaultpd)),
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
                            Text(
                              '(5.0)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: defaultpd),
                            ),
                          ],
                        ),
                        Text(
                          'Endereço da sala',
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: defaultpd / 1.5),
                        )
                      ]),
                ),
              )
            ]),
          ),
          Container(),
          Container()
        ]),
      ),
    );
  }
}
