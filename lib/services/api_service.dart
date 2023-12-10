import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sepatuku_app/data.dart';


class ApiService {
  final _baseUrl =
      'https://sepatukuapp-default-rtdb.asia-southeast1.firebasedatabase.app/sepatuku.json';

  Future<List<SepatuModel>> getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<SepatuModel> sepatu = data.entries
            .map((entry) =>
                SepatuModel.fromJson(Map<String, dynamic>.from(entry.value)))
            .toList();
        return sepatu;
      } else {
        print('Failed to load data - ${response.statusCode}: ${response.body}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to load data');
    }
  }
}

