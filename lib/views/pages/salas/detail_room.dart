import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/constants.dart';
import 'package:reserva_pra_mim/modelviews/reserve/reserve_controller.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';

class Detail_room extends StatefulWidget {
  const Detail_room({super.key});
  @override
  State<Detail_room> createState() => _Detail_roomState();
}

class _Detail_roomState extends State<Detail_room> {
  @override
  Widget build(BuildContext context) {
    final room = Get.arguments as Room;
    final controlReserve = Control_reserve();
    final controlRoom = ControlRoom();

    void reservedRoom() async {
      var success = true;
      try {
        Reserve newReserve = Reserve(
          id: FirebaseFirestore.instance.collection('reserves').doc().id,
          reservedRoom: room.id,
          userID: FirebaseAuth.instance.currentUser!.uid,
          bookingDateTime: DateTime.now(),
          deliveryDateTime: null,
          rating: null,
          finalPrice: 0,
          delivered: false,
        );

        await controlReserve.addReserve(newReserve);

        print('Nome: ${room.name}');
        Get.offNamed('/home');
      } catch (e) {
        print('Erro ao salvar a reserva: $e');
        success = false;
      }
      if (success) {
        controlRoom.reserveRoom(room);
      }
    }

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
              const SizedBox(
                height: 15,
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
                  onTap: () {
                    reservedRoom();
                  },
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: bgColor,
                    ),
                    child: const Center(
                      child: Text(
                        'Reservar',
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
