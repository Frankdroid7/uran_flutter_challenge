import 'dart:convert';

import 'package:uran_flutter_challange/exhibits_loader.dart';
import 'package:uran_flutter_challange/models/exhibit.dart';
import 'package:http/http.dart' as http;

class RestExhibitsLoader implements ExhibitsLoader {
  @override
  Future<List<Exhibit>> getExhibitList(http.Client client) async {
    String url = 'https://my-json-server.typicode.com/Reyst/exhibit_db/list';
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List responseBody = jsonDecode(response.body);
        return responseBody.map((json) => Exhibit.fromJson(json)).toList();
      } else {
        throw Exception('An error occurred');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
