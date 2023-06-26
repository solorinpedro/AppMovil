import 'dart:convert';

import 'package:app_movil/Model/EventoModel.dart';
import 'package:http/http.dart' as http;

class EventoApi {
  static Future<List<EventoModel>> getEvento() async {
    final response = await http
        .get(Uri.parse('http://www.myeventoapp.somee.com/Eventos/GetEventos'));
    if (response.statusCode == 200) {
      final List<dynamic> eventoList = json.decode(response.body);
      return eventoList
          .map((json) => EventoModel(
              id: json['id'],
              imagen: json['imagen'],
              fecha: json['fecha'],
              nombre: json['nombre'],
              lugar: json['lugar'],
              CantidadTicket: json['cantidadTicket']))
          .toList();
    } else {
      throw Exception('Error al obtener los datos de la API');
    }
  }

  static Future<bool> postEvento(int cantidad, String area,
      String nombreUsuario, String nombreEvento) async {
    final url = 'http://www.myeventoapp.somee.com/tickets';

    print('Cantidad${cantidad}');
    print('Area${area}');
    print('NombreUsuario${nombreUsuario}');
    print('NombreEvento${nombreEvento}');

    final requestBody = {
      'cantidad': cantidad,
      'precio': 0,
      'area': area,
      'nombreUsuario': nombreUsuario,
      'nombreEvento': nombreEvento
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    print('Codigo: ${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
