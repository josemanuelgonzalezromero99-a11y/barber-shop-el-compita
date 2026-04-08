import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/servicio.dart';
import '../models/cita.dart';
import '../models/usuario.dart';

class ApiService {

  // 🔥 IMPORTANTE: XAMPP en puerto 8080
  static String baseUrl = "http://127.0.0.1:8080/barber_shop_api/";

  // ==============================
  // 👤 CREAR USUARIO
  // ==============================
  static Future<Usuario?> crearUsuario(String nombre, String telefono) async {
    final response = await http.post(
      Uri.parse(baseUrl + "registro.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'nombre': nombre,
        'telefono': telefono,
      }),
    );

    print("Registro: ${response.body}");

    final data = jsonDecode(response.body);

    if (data['success']) {
      return Usuario(
        id: int.parse(data['usuario_id'].toString()),
        telefono: telefono,
        nombre: nombre,
      );
    }
    return null;
  }

  // ==============================
  // ✂️ SERVICIOS
  // ==============================
  static Future<List<Servicio>> getServicios() async {
    final response = await http.get(
      Uri.parse(baseUrl + "servicios.php"),
    );

    print("Servicios: ${response.body}");

    final List jsonData = jsonDecode(response.body);
    return jsonData.map((s) => Servicio.fromJson(s)).toList();
  }

  // ==============================
  // 📅 AGENDAR CITA (🔥 CORREGIDO)
  // ==============================
  static Future<bool> agendarCita(
    int usuarioId,
    int servicioId,
    String fecha,
    String hora,
  ) async {

    final response = await http.post(
      Uri.parse(baseUrl + "citas.php"), // 🔥 AQUÍ ESTABA EL ERROR
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'usuario_id': usuarioId,
        'servicio_id': servicioId,
        'fecha': fecha,
        'hora': hora,
      }),
    );

    print("Agendar: ${response.body}");

    final data = jsonDecode(response.body);
    return data['success'];
  }

  // ==============================
  // 📋 CITAS
  // ==============================
  static Future<List<Cita>> getCitas(int usuarioId) async {
    final response = await http.get(
      Uri.parse(baseUrl + "citas.php?usuario_id=$usuarioId"),
    );

    print("Citas: ${response.body}");

    final List jsonData = jsonDecode(response.body);
    return jsonData.map((c) => Cita.fromJson(c)).toList();
  }

  // ==============================
  // 🛠️ CREAR SERVICIO
  // ==============================
  static Future<bool> crearServicio(
    String nombre,
    String duracion,
    String precio,
  ) async {

    final response = await http.post(
      Uri.parse(baseUrl + "crear_servicio.php"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "nombre": nombre,
        "duracion": duracion,
        "precio": precio,
      }),
    );

    print("Crear servicio: ${response.body}");

    final data = jsonDecode(response.body);
    return data['success'];
  }
}