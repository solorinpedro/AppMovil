import 'package:app_movil/Service/EventoApi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatefulWidget {
  final int? id;
  final String? imagen;
  final String? fecha;
  final String? nombre;
  final String? lugar;

  const CardEvent(
      {Key? key, this.id, this.imagen, this.fecha, this.nombre, this.lugar})
      : super(key: key);

  @override
  State<CardEvent> createState() => _CardEventState();
}

class _CardEventState extends State<CardEvent> {
  final TextEditingController cantidadController = TextEditingController();

  String? area;
  int? cantidad;
  double precio = 0.0;

  void calcularPrecio() {
    if (area == 'Frente') {
      precio = cantidad! * 150.0;
    } else if (area == 'Backstage') {
      precio = cantidad! * 250.0;
    } else if (area == 'Anfiteatro') {
      precio = cantidad! * 100.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmacion'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: 'Area',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      ),
                      value: area,
                      onChanged: (String? newValue) {
                        setState(() {
                          area = newValue;
                          calcularPrecio();
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Frente',
                          child: Text('Frente'),
                        ),
                        DropdownMenuItem(
                          value: 'Backstage',
                          child: Text('Backstage'),
                        ),
                        DropdownMenuItem(
                          value: 'Anfiteatro',
                          child: Text('Anfiteatro'),
                        ),
                      ]),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: cantidadController,
                    onChanged: (value) {
                      cantidad = int.tryParse(value);
                      calcularPrecio();
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Cantidad',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10), //Agrega espacio alrededor del texto
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Continuar'),
                  onPressed: () {
                    if (EventoApi.postEvento(
                            cantidad!,
                            precio,
                            area!,
                            FirebaseAuth.instance.currentUser!.displayName!,
                            widget.nombre!) ==
                        true) {
                      print('Correcto');
                    } else {
                      print('Incorrecto');
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueAccent),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.imagen!,
                width: 250,
                height: 200,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.fecha!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.nombre!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    widget.lugar!,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: '',
                        color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
