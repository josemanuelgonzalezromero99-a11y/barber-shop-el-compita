import 'package:flutter/material.dart';
import '../models/cita.dart';
import '../services/api_service.dart';

class MisCitasScreen extends StatefulWidget {
  final int usuarioId;
  MisCitasScreen({required this.usuarioId});

  @override
  _MisCitasScreenState createState() => _MisCitasScreenState();
}

class _MisCitasScreenState extends State<MisCitasScreen> {
  List<Cita> citas = [];

  @override
  void initState() {
    super.initState();
    ApiService.getCitas(widget.usuarioId).then((list) {
      setState(() {
        citas = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mis Citas")),
      body: ListView.builder(
        itemCount: citas.length,
        itemBuilder: (context, index) {
          final c = citas[index];
          return ListTile(
            title: Text(c.servicio),
            subtitle: Text("${c.fecha} ${c.hora} - ${c.estado}")
          );
        },
      ),
    );
  }
}