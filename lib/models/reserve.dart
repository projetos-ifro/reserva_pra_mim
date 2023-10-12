import 'room.dart';

class Reserve {
  int id;
  Room reservedRoom;
  DateTime bookingDateTime;
  DateTime? deliveryDateTime;
  double finalPrice;
  String userID;

  Reserve({
    required this.id,
    required this.reservedRoom,
    required this.bookingDateTime,
    this.deliveryDateTime,
    required this.finalPrice,
    required this.userID,
  });
}
