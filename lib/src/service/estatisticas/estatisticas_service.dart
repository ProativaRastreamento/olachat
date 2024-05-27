import 'dart:convert';
import 'package:http/http.dart' as http;

class EstatisticasService {
  static const String baseUrl = 'https://backproativa.olachat.io';

  Future<Map<String, dynamic>> getDashTicketsAndTimes(Map<String, String> params) async {
    final uri = Uri.parse('$baseUrl/statistics-tickets-times').replace(queryParameters: params);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar dados de tickets e tempos');
    }
  }

  // Outros métodos...
}
