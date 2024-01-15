import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class AddLoadOrTimeService {
  Future<Map<String, dynamic>?> updateWorkout(
      {required String treinoId,
      required String nome,
      int? carga, String? tempo}) async {

    final body = {
      'treinoId': treinoId,
      'nome': nome,
      'carga': carga.toString(),
      'tempo': tempo.toString(),
    };

    try {
      final response = await http.put(
        Uri.https(Utils.mainUrl.substring(8), 'adicionarCargaOuTempo'),
        body: body,
      );

      final responseDecoded = jsonDecode(response.body);

      print(
          'UserService Response: $responseDecoded, statusCode: ${response.statusCode}');

      return responseDecoded;
    } catch (e) {
      print("Error: $e");
      return {"Error": e.toString()};
    }
  }
}