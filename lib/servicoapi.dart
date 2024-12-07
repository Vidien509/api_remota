import 'dart:convert';
import 'package:http/http.dart' as http;
import 'cidade.dart';

class ServicoApi {
  static const String apiUrl = 'https://arquivos.ectare.com.br/cidades.json';

  static Future<List<Cidade>> fetchCidades() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((json) => Cidade.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }
}
