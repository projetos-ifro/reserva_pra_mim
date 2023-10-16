import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/views/widgets/card_addons_room.dart';

class Detail_room extends StatefulWidget {
  const Detail_room({super.key});
  @override
  State<Detail_room> createState() => _Detail_roomState();
}

class _Detail_roomState extends State<Detail_room> {
  @override
  Widget build(BuildContext context) {
    final room = Get.arguments as Room;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: bgColor),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(defaultpd),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.name,
                style: TextStyle(
                    fontSize: defaultpd * 2, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Descrição',
                style: TextStyle(
                    fontSize: defaultpd * 1.5, fontWeight: FontWeight.bold),
              ),
              Text(
                room.description,
                style:
                    TextStyle(fontSize: defaultpd, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Capacidade: ${room.capacity}',
                      style: TextStyle(
                          fontSize: defaultpd, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    width: 5,
                  ),
                  const FaIcon(Icons.people_alt_rounded)
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              CheckboxListTile(
                title: const Text('Wifi'),
                value: room.withWifi,
                onChanged: null,
              ),
              CheckboxListTile(
                title: const Text('DataShow'),
                value: room.withDatashow,
                onChanged: null,
              ),
              CheckboxListTile(
                title: const Text('Caixa de Som'),
                value: room.withSoundBox,
                onChanged: null,
              ),
              CheckboxListTile(
                title: const Text('Tv'),
                value: room.withTv,
                onChanged: null,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Preço: R\$ ${room.pricePerHour},00 / Hr',
                style: TextStyle(
                    color: bgColor,
                    fontSize: defaultpd * 1.5,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 120,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: bgColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Adicionar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
