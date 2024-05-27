import 'dart:convert';
import 'package:http/http.dart' as http;

class ConfiguracoesService {
  static const String baseUrl = 'http://seuapi.com';

  Future<List<dynamic>> listarConfiguracoes() async {
    final response = await http.get(Uri.parse('$baseUrl/settings/'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao carregar configurações');
    }
  }
}
