class Room {
  int id;
  bool isAvailable;
  String name;
  String description;
  bool withDatashow;
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
    required this.withTv,
    required this.withSoundBox,
    required this.roomImage,
    required this.pricePerHour,
    required this.capacity,
  });
}
