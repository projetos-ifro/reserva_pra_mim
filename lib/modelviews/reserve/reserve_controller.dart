import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';

class Control_reserve extends GetxController {
  final firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<void> addReserve(Reserve reserve) async {
    try {
      isLoading(true);
      await FirebaseFirestore.instance
          .collection('reserves')
          .add(reserve.toMap());
    } catch (e) {
      print("Erro ao tentar adicionar a reserva: $e");
    } finally {
      isLoading(false);
      Get.back();
    }
  }

  Future<List<Reserve>> getActiveUserReservations() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return []; // Retorna uma lista vazia se o usuário não estiver autenticado
      }

      QuerySnapshot querySnapshot = await firestore
          .collection('reserves')
          .where('userID',
              isEqualTo: user.uid) // Filtre pelo ID do usuário logado
          .where('delivered',
              isEqualTo: false) // Filtre pelo campo 'delivered' igual a false
          .get();

      List<Reserve> reserves = [];

      Future<List<Reserve>> getActiveUserReservations() async {
        try {
          final user = FirebaseAuth.instance.currentUser;

          if (user == null) {
            return []; // Retorna uma lista vazia se o usuário não estiver autenticado
          }

          QuerySnapshot querySnapshot = await firestore
              .collection('reserves')
              .where('userID',
                  isEqualTo: user.uid) // Filtre pelo ID do usuário logado
              .where('delivered',
                  isEqualTo:
                      false) // Filtre pelo campo 'delivered' igual a false
              .get();

          List<Reserve> reserves = [];

          for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
            var data = docSnapshot.data() as Map<String, dynamic>;

            DocumentReference roomRef = data['reservedRoom'];
            DocumentSnapshot<Map<String, dynamic>> roomSnapshot =
                (await roomRef.get()) as DocumentSnapshot<Map<String, dynamic>>;
            Room room = Room.fromFirestore(roomSnapshot);

            Reserve reserve = Reserve(
              id: docSnapshot.id,
              reservedRoom: data[
                  'reservedRoom'], // Use o objeto Room em vez da referência
              userID: data['userID'],
              bookingDateTime: data['bookingDateTime'],
              deliveryDateTime: data['deliveryDateTime'],
              rating: data['rating'],
              finalPrice: data['finalPrice'],
              delivered: data['delivered'],
            );

            reserves.add(reserve);
          }

          return reserves;
        } catch (e) {
          print('Erro ao obter as reservas ativas do usuário: $e');
          return [];
        }
      }

      return reserves;
    } catch (e) {
      print('Erro ao obter as reservas ativas do usuário: $e');
      return [];
    }
  }
}
