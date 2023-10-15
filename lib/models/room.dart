import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  String id;
  bool isAvailable;
  String name;
  String description;
  bool withDatashow;
  bool withWifi;
  bool withTv;
  bool withSoundBox;
  String roomImage;
  double pricePerHour;
  double capacity;

  Room({
    required this.id,
    required this.isAvailable,
    required this.name,
    required this.description,
    required this.withDatashow,
    required this.withWifi,
    required this.withTv,
    required this.withSoundBox,
    required this.roomImage,
    required this.pricePerHour,
    required this.capacity,
  });

  factory Room.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Room(
      id: data['id'],
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
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isAvailable': isAvailable,
      'name': name,
      'description': description,
      'withDatashow': withDatashow,
      'withWifi': withWifi,
      'withTv': withTv,
      'withSoundBox': withSoundBox,
      'roomImage': roomImage,
      'pricePerHour': pricePerHour,
      'capacity': capacity,
    };
  }
}
