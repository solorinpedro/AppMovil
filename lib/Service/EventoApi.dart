import 'dart:convert';

import 'package:app_movil/Model/EventoModel.dart';
import 'package:app_movil/Model/TicketModel.dart';
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

  static Future<bool> postEvento(int cantidad, double precio, String area,
      String nombreUsuario, String nombreEvento) async {
    final url = 'http://www.myeventoapp.somee.com/Tickets/PostTicket';
    print('Cantidad: $cantidad');
    print('Precio: $precio');
    print('Area: $area');
    print('NombreUsuario: $nombreUsuario');
    print('NombreEvento: $nombreEvento');

    final requestBody = {
      'cantidad': cantidad,
      'precio': precio,
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

  static Future<List<TicketModel>> getTickets() async {
    final response = await http
        .get(Uri.parse('http://www.myeventoapp.somee.com/Tickets/GetTikets'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> ticketList = json.decode(response.body);
      return ticketList
          .map((json) => TicketModel(
              id: json['id'],
              precio: json['precio'],
              cantidad: json['cantidad'],
              area: json['area'],
              nombreUsuario: json['nombreUsuario'],
              nombreEvento: json['nombreEvento']))
          .toList();
    } else {
      throw Exception('Error al obtener los datos de la API');
    }
  }
}
