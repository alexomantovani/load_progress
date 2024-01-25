import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class AddLoadOrTimeService {
  final http.Client  client;

  AddLoadOrTimeService({required this.client});

  Future<Map<String, dynamic>?> updateExercises(
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
      final response = await client.put(
        Uri.https(Utils.mainUrl.substring(8), 'adicionarCargaOuTempo'),
        body: body,
      );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseDecoded = jsonDecode(
              '{"Success": "${response.body}", "statusCode": "${response.statusCode}"}');
          print(responseDecoded);
          return responseDecoded;
        } else {
          throw throw const FormatException('The response.body is null');
        }
      } else {
        throw FormatException(response.body.toString());
      }
    } catch (e) {
      print("Error: $e");
      return {"Error": e.toString()};
    }
  }
}