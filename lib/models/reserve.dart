import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reserva_pra_mim/models/room.dart';

class Reserve {
  String id;
  String reservedRoom;
  DateTime bookingDateTime;
  DateTime? deliveryDateTime;
  double? rating;
  double finalPrice;
  String userID;
  bool delivered;

  Reserve({
    required this.id,
    required this.reservedRoom,
    required this.bookingDateTime,
    this.deliveryDateTime,
    this.rating,
    required this.finalPrice,
    required this.userID,
    required this.delivered,
  });

  // Método para converter um objeto Reserve em um mapa (Map<String, dynamic>)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservedRoom': reservedRoom, // Mapeando o objeto Room
      'bookingDateTime': bookingDateTime,
      'deliveryDateTime': deliveryDateTime,
      'rating': rating,
      'finalPrice': finalPrice,
      'userID': userID,
      'delivered': delivered,
    };
  }

  factory Reserve.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Reserve(
      id: data['id'],
      reservedRoom: data['reservedRoom'], // Obtenha o documento referenciado
      bookingDateTime: data['bookingDateTime'].toDate(),
      deliveryDateTime: data['deliveryDateTime'] != null
          ? data['deliveryDateTime'].toDate()
          : null,
      rating: data['rating'],
      finalPrice: data['finalPrice'],
      userID: data['userID'],
      delivered: data['delivered'],
    );
  }

  Future<Room> getRoom() async {
    // Obter a referência para o documento da sala
    DocumentReference roomRef =
        FirebaseFirestore.instance.collection('rooms').doc(reservedRoom);

    // Obter o snapshot do documento da sala
    DocumentSnapshot<Object?> roomSnapshot = await roomRef.get();

    // Converter o objeto DocumentSnapshot<Object?> para o tipo DocumentSnapshot<Map<String, dynamic>>
    DocumentSnapshot<Map<String, dynamic>> roomSnapshotTyped =
        roomSnapshot as DocumentSnapshot<Map<String, dynamic>>;

    // Criar um objeto Room a partir do snapshot do documento da sala
    return Room.fromFirestore(roomSnapshotTyped);
  }
}
