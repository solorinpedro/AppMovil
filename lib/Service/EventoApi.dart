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
              lugar: json['lugar']))
          .toList();
    } else {
      throw Exception('Error al obtener los datos de la API');
    }
  }
}
