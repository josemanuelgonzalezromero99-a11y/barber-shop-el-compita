import 'package:flutter/material.dart';
import '../models/cita.dart';
import '../services/api_service.dart';

class AdminCitasScreen extends StatefulWidget {
  @override
  _AdminCitasScreenState createState() => _AdminCitasScreenState();
}

class _AdminCitasScreenState extends State<AdminCitasScreen> {
  List<Cita> citas = [];

  @override
  void initState() {
    super.initState();
    cargar();
  }

  void cargar() async {
    // usamos usuario_id = 0 para traer todas
    final data = await ApiService.getCitas(0);
    setState(() => citas = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Citas")),
      body: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) {
          final c = citas[index];

          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(c.servicio),
              subtitle: Text("${c.fecha} - ${c.estado}"),
            ),
          );
        },
      ),
    );
  }
}