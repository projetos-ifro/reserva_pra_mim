import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reserva_pra_mim/models/reserve.dart';

class Control_reserve extends GetxController {
  final firestore = FirebaseFirestore.instance;
  var isLoading = false.obs;

  Future<void> addReserve(Reserve reserve) async {
    final user = FirebaseAuth.instance.currentUser; // Obtenha o usuário autenticado
    if (user == null) {
      // O usuário não está autenticado, trate conforme desejado.
      print("Você não está autenticado. Faça o login para adicionar uma reserva.");
      return;
    }

    try {
      isLoading(true);
      // Adicione a reserva com o ID do usuário
      await FirebaseFirestore.instance
          .collection('reserves')
          .add({
        ...reserve.toMap(),
        'userID': user.uid,
      });
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

  String calculateTimePassed(DateTime targetTime) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(targetTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} segundos atrás';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutos atrás';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} horas atrás';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} dias atrás';
    } else {
      final weeks = difference.inDays ~/ 7;
      return '$weeks semanas atrás';
    }
  }

  Future<void> updateReserve(Reserve reservation) async {
    try {
      await FirebaseFirestore.instance
          .collection('reserves')
          .doc(reservation.id)
          .update({
        'deliveryDateTime': reservation.deliveryDateTime,
        'rating': reservation.rating,
        'finalPrice': reservation.finalPrice,
        'delivered': reservation.delivered,
      });
      print('Reserva atualizada com sucesso');
    } catch (e) {
      print('Erro ao atualizar a reserva: $e');
    }
  }
}
