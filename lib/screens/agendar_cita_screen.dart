import 'package:flutter/material.dart';
import '../models/servicio.dart';
import '../services/api_service.dart';

class AgendarCitaScreen extends StatefulWidget {
  final int usuarioId;
  final Servicio servicio;

  AgendarCitaScreen({
    required this.usuarioId,
    required this.servicio,
  });

  @override
  _AgendarCitaScreenState createState() => _AgendarCitaScreenState();
}

class _AgendarCitaScreenState extends State<AgendarCitaScreen> {

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String? imagenSeleccionada;

  // 🔥 CABALLERO
  List<String> cortesCaballero = [
    "1.png",
    "2.png",
    "3.png",
    "4.png",
    "5.png"
  ];

  List<String> barbas = [
    "barba1.png",
    "barba2.png",
    "barba3.png",
    "barba4.png",
    "barba5.png",
    "barba6.png"
  ];

  // 🔥 DAMA
  List<String> cortesDama = [
    "corte1.png",
    "corte2.png",
    "corte3.png",
    "corte4.png",
    
    "corte6.png"
  ];

  List<String> lavados = [
    "lavado1.png",
    "lavado2.png",
    "lavado3.png",
    "lavado4.png",
    "lavado5.png",
    "lavado6.png"
  ];

  // 🔥 VALIDACIONES DE SERVICIO
  bool esCaballeroCorte() {
    return widget.servicio.nombre.toLowerCase().contains("corte") &&
           widget.servicio.nombre.toLowerCase().contains("caballero");
  }

  bool esBarba() {
    return widget.servicio.nombre.toLowerCase().contains("barba");
  }

  bool esDamaCorte() {
    return widget.servicio.nombre.toLowerCase().contains("corte") &&
           widget.servicio.nombre.toLowerCase().contains("dama");
  }

  bool esLavado() {
    return widget.servicio.nombre.toLowerCase().contains("lavado");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.servicio.nombre),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // =========================
            // 💈 CABALLERO
            // =========================
            if (esCaballeroCorte() || esBarba()) ...[

              Text(
                "Servicios Caballero 💈",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              if (esCaballeroCorte()) ...[
                Text("Selecciona tu corte"),
                SizedBox(height: 10),
                buildGrid(cortesCaballero),
                SizedBox(height: 25),
              ],

              if (esBarba()) ...[
                Text("Selecciona tu barba 🧔"),
                SizedBox(height: 10),
                buildGrid(barbas),
                SizedBox(height: 25),
              ],
            ],

            // =========================
            // 💇‍♀️ DAMA
            // =========================
            if (esDamaCorte() || esLavado()) ...[

              Text(
                "Servicios Dama 💇‍♀️",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

              if (esDamaCorte()) ...[
                Text("Corte de dama"),
                SizedBox(height: 10),
                buildGrid(cortesDama),
                SizedBox(height: 25),
              ],

              if (esLavado()) ...[
                Text("Lavado de cabello"),
                SizedBox(height: 10),
                buildGrid(lavados),
                SizedBox(height: 25),
              ],
            ],

            // =========================
            // 📅 FECHA
            // =========================
            Text("Selecciona fecha"),
            SizedBox(height: 10),

            ElevatedButton(
              child: Text("${selectedDate.toLocal()}".split(' ')[0]),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  setState(() => selectedDate = picked);
                }
              },
            ),

            SizedBox(height: 20),

            // =========================
            // ⏰ HORA
            // =========================
            Text("Selecciona hora"),
            SizedBox(height: 10),

            ElevatedButton(
              child: Text(selectedTime.format(context)),
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                if (picked != null) {
                  setState(() => selectedTime = picked);
                }
              },
            ),

            SizedBox(height: 25),

            // =========================
            // 🔘 CONFIRMAR
            // =========================
            ElevatedButton(
              child: Text("Confirmar cita"),
              onPressed: () async {

                if ((esCaballeroCorte() || esBarba() || esDamaCorte() || esLavado())
                    && imagenSeleccionada == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Selecciona una opción")),
                  );
                  return;
                }

                String hora = "${selectedTime.hour}:${selectedTime.minute}";

                bool ok = await ApiService.agendarCita(
                  widget.usuarioId,
                  widget.servicio.id,
                  selectedDate.toIso8601String(),
                  hora,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(ok ? "Cita agendada" : "Hora ocupada"),
                  ),
                );
              },
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 🔥 GRID SIN ERRORES
  Widget buildGrid(List<String> lista) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: lista.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {

        final img = lista[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              imagenSeleccionada = img;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: imagenSeleccionada == img
                    ? Colors.cyan
                    : Colors.transparent,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/$img',
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}