import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reserva_pra_mim/models/reserve.dart';
import 'package:reserva_pra_mim/models/room.dart';
import 'package:reserva_pra_mim/modelviews/room/room_cotroller.dart';

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
          .where('userID', isEqualTo: user.uid)
          .where('delivered', isEqualTo: false)
          .get();

      List<Reserve> reserves = [];

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        var data = docSnapshot.data() as Map<String, dynamic>;

        // Converta os objetos Timestamp em DateTime
        DateTime bookingDateTime =
            (data['bookingDateTime'] as Timestamp).toDate();
        DateTime? deliveryDateTime = data['deliveryDateTime'] != null
            ? (data['deliveryDateTime'] as Timestamp).toDate()
            : null;

        Reserve reserve = Reserve(
          id: docSnapshot.id,
          reservedRoom: data['reservedRoom'],
          userID: data['userID'],
          bookingDateTime: bookingDateTime,
          deliveryDateTime: deliveryDateTime,
          rating: data['rating'],
          finalPrice: data['finalPrice'].toDouble(),
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
}
