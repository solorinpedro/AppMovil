import 'package:app_movil/Model/EventoModel.dart';
import 'package:app_movil/Page/TicketsPage.dart';
import 'package:app_movil/Service/EventoApi.dart';
import 'package:app_movil/Widget/CardEvent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../auth_serve.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String? user = FirebaseAuth.instance.currentUser!.email ?? FirebaseAuth.instance.currentUser!.displayName;
  Future<List<EventoModel>>? _futureEventos;
  Future<List<EventoModel>> getEventos() async {
    return await EventoApi.getEvento();
  }

  @override
  void initState() {
    super.initState();
    _futureEventos = getEventos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TicketsPage(),
                ));
          },
          child: Icon(Icons.event),
        ),
        title: Text('EventoApp', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Text(
              //   FirebaseAuth.instance.currentUser!.displayName!,
              //   style: const TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.black87),
              // ),
              Text(
                FirebaseAuth.instance.currentUser!.displayName!,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              FutureBuilder<List<EventoModel>>(
                future: _futureEventos,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(
                      child: Text('Error al obtener los eventos'),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data?.isEmpty == true) {
                    return Center(
                      child: Text('No hay Eventos'),
                    );
                  }
                  return Column(
                    children: [
                      for (var evento in snapshot.data!)
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: CardEvent(
                                  imagen: evento.imagen,
                                  fecha: evento.fecha,
                                  nombre: evento.nombre,
                                  lugar: evento.lugar,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                padding: const EdgeInsets.all(10),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'LOG OUT',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                onPressed: () {
                  AuthService().signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
