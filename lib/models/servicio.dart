class Servicio {
  int id;
  String nombre;
  int duracion;
  double precio;
  String descripcion;
  String imagen;

  Servicio({
    required this.id,
    required this.nombre,
    required this.duracion,
    required this.precio,
    required this.descripcion,
    required this.imagen,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      id: int.parse(json['id'].toString()),
      nombre: json['nombre'] ?? '',
      duracion: int.tryParse(json['duracion'].toString()) ?? 0,
      precio: double.tryParse(json['precio'].toString()) ?? 0.0,
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }
}