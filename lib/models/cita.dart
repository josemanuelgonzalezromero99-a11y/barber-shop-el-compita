class Cita {
  int id;
  String servicio;
  int duracion;
  double precio;
  String fecha;
  String estado;
  String hora;

  Cita({required this.id, required this.servicio, required this.duracion, required this.precio, required this.fecha, required this.estado, required this.hora});

  factory Cita.fromJson(Map<String, dynamic> json) {
    return Cita(
      id: json['id'],
      servicio: json['servicio'],
      duracion: json['duracion'],
      precio: double.parse(json['precio'].toString()),
      fecha: json['fecha'],
      estado: json['estado'],
      hora: json['hora'],
    );
  }
}