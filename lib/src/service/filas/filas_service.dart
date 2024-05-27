import 'dart:convert';
import 'package:http/http.dart' as http;

class FilasService {
  static const String baseUrl = 'http://seuapi.com';

  Future<List<dynamic>> listarFilas() async {
    final response = await http.get(Uri.parse('$baseUrl/queue/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar filas');
    }
  }
}
