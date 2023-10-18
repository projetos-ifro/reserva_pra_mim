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

  static Reserve fromMap(Map<String, dynamic> data) {
    Room? room;

    if (data['reservedRoom'] != null) {
      room = Room.fromMap(data['reservedRoom']);
    }

    return Reserve(
      id: data['id'],
      reservedRoom: room!.id,
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

  static Future<Reserve> fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) async {
    Room? room;
    final data = snapshot.data() as Map<String, dynamic>;

    await FirebaseFirestore.instance
        .collection('rooms')
        .doc(data['reservedRoom'])
        .get()
        .then((DocumentSnapshot docSnapshot) {
      var id = docSnapshot.id;
      var data = docSnapshot.data() as Map<String, dynamic>;
      var isAvailable = data['isAvailable'];
      var name = data['name'];
      var description = data['description'];
      var withDatashow = data['withDatashow'];
      var withWifi = data['withWifi'];
      var withTv = data['withTv'];
      var withSoundBox = data['withSoundBox'];
      var roomImage = data['roomImage'];
      var pricePerHour = data['pricePerHour'];
      var capacity = data['capacity'];

      room = Room(
        id: id,
        isAvailable: isAvailable,
        name: name,
        description: description,
        withDatashow: withDatashow,
        withWifi: withWifi,
        withTv: withTv,
        withSoundBox: withSoundBox,
        roomImage: roomImage,
        pricePerHour: pricePerHour,
        capacity: capacity,
      );
    });

    return Reserve(
      id: data['id'],
      reservedRoom: room!.id,
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
}
