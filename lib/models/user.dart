class User {
  int id;
  String name;
  String email;
  String phone;
  bool isAdmin;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.isAdmin = false});
}
