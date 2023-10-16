class Usuario {
  final String id;
  final String nome;
  final bool isAdmin;

  Usuario({
    required this.id,
    required this.nome,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'isAdmin': isAdmin,
    };
  }

  factory Usuario.fromFirestore(Map<String, dynamic> data) {
    return Usuario(
      id: data['id'],
      nome: data['nome'],
      isAdmin: data['isAdmin'],
    );
  }
}