import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {
  final String baseUrl;

  RequestService({required this.baseUrl});

  Future<http.Response> get(String endpoint, {Map<String, String>? params}) async {
    var uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
    return await http.get(uri);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.post(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> data) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.put(uri, body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
  }

  Future<http.Response> delete(String endpoint) async {
    var uri = Uri.parse('$baseUrl$endpoint');
    return await http.delete(uri);
  }
}
