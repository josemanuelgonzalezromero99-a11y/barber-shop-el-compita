class Usuario {
  int id;
  String telefono;
  String? nombre;

  Usuario({required this.id, required this.telefono, this.nombre});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      telefono: json['telefono'],
      nombre: json['nombre'],
    );
  }
}