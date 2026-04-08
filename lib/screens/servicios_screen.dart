import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/servicio.dart';
import '../services/api_service.dart';
import 'agendar_cita_screen.dart';
import 'chat_screen.dart';

class ServiciosScreen extends StatefulWidget {
  final int usuarioId;
  ServiciosScreen({required this.usuarioId});

  @override
  _ServiciosScreenState createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {

  List<Servicio> servicios = [];
  bool loading = true;

  PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> banners = [
    "🔥 Promo: Corte + Barba en \$150",
    "✂️ Corte Caballero \$130",
    "🧔 Barba \$80",
  ];

  @override
  void initState() {
    super.initState();
    cargarServicios();
    autoScrollBanner();
  }

  void cargarServicios() async {
    final list = await ApiService.getServicios();

    setState(() {
      servicios = list;
      loading = false;
    });
  }

  // 🔥 AUTO SCROLL BANNER
  void autoScrollBanner() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  // 🔥 WHATSAPP
  void abrirWhatsApp() async {
    final url = Uri.parse("https://wa.me/524612989035?text=Hola quiero una cita");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  // 🔥 FACEBOOK
  void abrirFacebook() async {
    final url = Uri.parse("https://www.facebook.com/?checkpoint_src=any");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  // 🔥 INSTAGRAM
  void abrirInstagram() async {
    final url = Uri.parse("https://www.instagram.com/tuUsuario");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("¿Como Podemos Ayudarte?💈"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChatScreen()),
              );
            },
          )
        ],
      ),

      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [

                // 🔥 BANNER ANIMADO
                Container(
                  height: 50,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: banners.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Colors.grey[900]!],
                          ),
                        ),
                        child: Text(
                          banners[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 🔥 LISTA
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(15),
                    itemCount: servicios.length,
                    itemBuilder: (context, index) {

                      final s = servicios[index];

                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(bottom: 15),

                        child: Padding(
                          padding: EdgeInsets.all(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                s.nombre,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 10),

                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 18),
                                  SizedBox(width: 5),
                                  Text("${s.duracion} min"),
                                ],
                              ),

                              SizedBox(height: 5),

                              Row(
                                children: [
                                  Icon(Icons.attach_money, size: 18),
                                  SizedBox(width: 5),

                                  // 🔥 PRECIOS FORZADOS
                                  Text(
                                    s.nombre.toLowerCase().contains("barba")
                                        ? "80"
                                        : "130",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 15),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  ElevatedButton.icon(
                                    icon: Icon(Icons.calendar_today),
                                    label: Text("Agendar"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AgendarCitaScreen(
                                            usuarioId: widget.usuarioId,
                                            servicio: s,
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  IconButton(
                                    icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                                    onPressed: abrirWhatsApp,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

      // 🔥 FOOTER
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(12),
        color: Colors.black87,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Horarios:",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text(
                      "L-V: 2pm-4pm / 5:30pm-8:30pm\n"
                      "Sáb: 8am-12pm / 1:30pm-5pm / 6:30pm-9pm",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                      onPressed: abrirWhatsApp,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                      onPressed: abrirFacebook,
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                      onPressed: abrirInstagram,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Contáctanos", style: TextStyle(color: Colors.white)),
                SizedBox(width: 10),
                FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green, size: 18),
                SizedBox(width: 10),
                FaIcon(FontAwesomeIcons.facebook, color: Colors.blue, size: 18),
                SizedBox(width: 10),
                FaIcon(FontAwesomeIcons.instagram, color: Colors.pink, size: 18),
              ],
            ),

            SizedBox(height: 5),

            Text(
              "💈 Barber Shop El Compita",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}