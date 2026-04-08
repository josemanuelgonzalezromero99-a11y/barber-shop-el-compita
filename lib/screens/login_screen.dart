import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/api_service.dart';
import 'servicios_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController telefono = TextEditingController();
  TextEditingController nombre = TextEditingController();

  bool loading = false;

  // 🔥 WHATSAPP
  void abrirWhatsApp() async {
    final url = Uri.parse("https://wa.me/5214612989035");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // 🔥 FACEBOOK
  void abrirFacebook() async {
    final url = Uri.parse("https://www.facebook.com/share/18K7cYasUC/");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // 🔥 INSTAGRAM (NUEVO)
  void abrirInstagram() async {
    final url = Uri.parse("https://www.instagram.com/tuUsuario");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  void ingresar() async {
    if (nombre.text.isEmpty || telefono.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Completa todos los campos")));
      return;
    }

    if (telefono.text.length < 10) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Teléfono inválido")));
      return;
    }

    setState(() => loading = true);

    var usuario = await ApiService.crearUsuario(nombre.text, telefono.text);

    setState(() => loading = false);

    if (usuario != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ServiciosScreen(usuarioId: usuario.id),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error al ingresar")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Barbería "El Compita" 💈')),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.cyanAccent, Colors.white]),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 40),

                Image.asset('assets/images/tijeras.png', height: 200),

                SizedBox(height: 40),

                Text(
                  "Barber Shop 💈",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "Ingresa tus datos",
                  style: TextStyle(color: Colors.black),
                ),

                SizedBox(height: 30),

                // 👤 NOMBRE
                TextField(
                  controller: nombre,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Nombre',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // 📱 TELÉFONO
                TextField(
                  controller: telefono,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Teléfono',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // 🔥 BOTÓN
                loading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: ingresar,
                        child: Text("Entrar"),
                      ),

                SizedBox(height: 40),

                Divider(),

                Text("Contáctanos"),

                SizedBox(height: 10),

                // 🔥 REDES COMPLETAS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                      ),
                      onPressed: abrirWhatsApp,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                      onPressed: abrirFacebook,
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Colors.pink,
                      ),
                      onPressed: abrirInstagram,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}