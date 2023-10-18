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

      // Atualize o campo 'isAvailable' para false
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

  Future<Room> getRoomById(String reservedRoomId) async {
    // Obter uma referência para a coleção de salas no Firebase Firestore
    final roomsCollection = FirebaseFirestore.instance.collection('rooms');

    // Obter a sala com o id especificado
    final roomDocument = await roomsCollection.doc(reservedRoomId).get();

    // Verificar se a sala existe
    if (roomDocument == null) {
      throw Exception('Sala não encontrada');
    }

    // Converter a sala em um objeto Room
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
}
