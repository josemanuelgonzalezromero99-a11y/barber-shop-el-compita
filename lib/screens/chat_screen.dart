import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController mensajeController = TextEditingController();

  List<Map<String, dynamic>> mensajes = [];

  void enviarMensaje() {

    if (mensajeController.text.isEmpty) return;

    setState(() {
      mensajes.add({
        "texto": mensajeController.text,
        "yo": true,
      });
    });

    // 🔥 RESPUESTA AUTOMÁTICA (simula barber)
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        mensajes.add({
          "texto": "Gracias por tu mensaje 💈 en breve te atendemos",
          "yo": false,
        });
      });
    });

    mensajeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Chat Barber 💬"),
      ),

      body: Column(
        children: [

          // 🔥 MENSAJES
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: mensajes.length,
              itemBuilder: (context, index) {

                final m = mensajes[index];

                return Align(
                  alignment: m["yo"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: m["yo"]
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      m["texto"],
                      style: TextStyle(
                        color: m["yo"] ? Colors.black : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔥 INPUT
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[200],
            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: mensajeController,
                    decoration: InputDecoration(
                      hintText: "Escribe un mensaje...",
                      border: InputBorder.none,
                      iconColor: Colors.black
                    ),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: enviarMensaje,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}