// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/room.dart';

class ControlRoom extends GetxController {
  final firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;
  List<Room> listOfRooms = [];

  Future<void> reserveRoom(Room room) async {
    try {
      final roomReference =
          FirebaseFirestore.instance.collection('rooms').doc(room.id);
      await roomReference.update({'isAvailable': false});
    } catch (e) {
      print('Erro ao reservar a sala: $e');
    }
  }

  int setPrice(int price, bool value, int addon) {
    if (value) {
      price += addon;
    } else {
      price -= addon;
    }
    return price;
  }

  Future<void> addRoom(Room room) async {
    try {
      isLoading(true);
      await FirebaseFirestore.instance.collection('rooms').add(room.toMap());
    } catch (e) {
      print("Erro ao tentar adicionar a sala: $e");
    } finally {
      isLoading(false);
      Get.back();
    }
  }

  Future<Room?> getRoomById(String reservedRoomId) async {
    final roomsCollection = FirebaseFirestore.instance.collection('rooms');
    final roomDocument = await roomsCollection.doc(reservedRoomId).get();
    // ignore: unnecessary_null_comparison
    if (roomDocument == null) {
      throw Exception('Sala não encontrada');
    }
    return Room.fromFirestore(roomDocument);
  }

  Future<List<Room>> getRooms() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection('rooms').get();
      List<Room> rooms = [];

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        var data = docSnapshot.data() as Map<String, dynamic>;

        Room room = Room(
          id: docSnapshot.id,
          isAvailable: data['isAvailable'],
          name: data['name'],
          description: data['description'],
          withDatashow: data['withDatashow'],
          withWifi: data['withWifi'],
          withTv: data['withTv'],
          withSoundBox: data['withSoundBox'],
          roomImage: data['roomImage'],
          pricePerHour: data['pricePerHour'],
          capacity: data['capacity'],
        );

        rooms.add(room);
      }

      return rooms;
    } catch (e) {
      print('Erro ao obter as salas: $e');
      return [];
    }
  }

  Future<void> returnRoom(Room? room) async {
    try {
      final roomCollection = FirebaseFirestore.instance.collection('rooms');
      final roomQuery =
          await roomCollection.where('id', isEqualTo: room!.id).get();

      if (roomQuery.docs.isNotEmpty) {
        // Encontrou a sala com o ID correspondente
        final roomDoc = roomQuery.docs.first;
        await roomCollection.doc(roomDoc.id).update({'isAvailable': true});
        print('Sala marcada como disponível novamente');
      } else {
        print('Sala com ID não encontrado');
      }
    } catch (e) {
      print('Erro ao marcar a sala como disponível novamente: $e');
    }
  }
}
