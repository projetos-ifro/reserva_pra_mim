import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:reserva_pra_mim/models/reserve.dart';


class Historico_Controller {

  final firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<List<Reserve>> getCompletedUserReservations() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return [
        ];
      }

      QuerySnapshot querySnapshot = await firestore
          .collection('reserves')
          .where('userID', isEqualTo: user.uid)
          .where('delivered', isEqualTo: true)
          .get();

      List<Reserve> reserves = [];

      for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
        var data = docSnapshot.data() as Map<String, dynamic>;

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
      print('Erro ao obter as reservas finalizadas do usuário: $e');
      return [];
    }
  }
}
