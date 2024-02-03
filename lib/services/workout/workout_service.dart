import 'dart:convert';

import 'package:load_progress/models/workout/workout.dart';

import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class WorkoutService {
  http.Client? client;

  WorkoutService({this.client});

  Future<Map<String, dynamic>> createWorkout({
    required String email,
    required String tipoTreino,
    required List<dynamic> exercicios,
  }) async {
    final body = {
      "email": email,
      "tipoTreino": tipoTreino,
      "exercicios": exercicios[0],
    };

    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    try {
      final response = client != null
          ? await client!.post(
              Uri.parse('${Utils.mainUrl}/criarTreino'),
              body: json.encode(body),
              headers: headers,
            )
          : await http.post(
              Uri.parse('${Utils.mainUrl}/criarTreino'),
              body: json.encode(body),
              headers: headers,
            );

            print('response: ${response.body} , statuscode: ${response.statusCode}');

      if (response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> responseDecoded = jsonDecode(
              '{"success": "${jsonDecode(response.body)}", "statusCode": "${response.statusCode}"}');
          print(responseDecoded);
          return responseDecoded;
        } else {
          throw const FormatException('The response.body is null');
        }
      } else {
        throw FormatException(response.body.toString());
      }
    } on FormatException catch (e) {
      // print('Error: $e');
      throw FormatException(e.toString());
    }
  }

  Future<List<Workout?>?> listWorkouts(String usuarioId) async {
    final params = {"usuarioId": usuarioId};

    try {
      final response = client != null
          ? await client!.get(Uri.https(
              Utils.mainUrl.substring(8), '/listarTreinosDoUsuario', params))
          : await http.get(Uri.https(
              Utils.mainUrl.substring(8), '/listarTreinosDoUsuario', params));
      final responseDecoded = await jsonDecode(response.body) as List;
      print(
          'WorkoutService Response: ${response.body}, statusCode: ${response.statusCode}');

      final workouts =
          responseDecoded.map<Workout>((e) => Workout.fromMap(e)).toList();

      return workouts;
    } catch (e) {
      print("Error catch: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateWorkout(
      {required String treinoId,
      required String tipoTreino,
      required List<Map<String, dynamic>> exercicios}) async {
    final params = {'treinoId': treinoId};

    final body = {
      'exercicios': json.encode(exercicios),
      'tipoTreino': tipoTreino,
    };

    try {
      final response = client != null
          ? await client!.put(
              Uri.https(Utils.mainUrl.substring(8), 'atualizarTreino', params),
              body: body,
            )
          : await http.put(
              Uri.https(Utils.mainUrl.substring(8), 'atualizarTreino', params),
              body: body,
            );

      // final responseDecoded = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseDecoded = jsonDecode(
              '{"Success": "${response.body}", "statusCode": "${response.statusCode}"}');
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

  Future<Map<String, dynamic>?> deleteWorkout(String treinoId) async {
    final params = {"treinoId": treinoId};

    try {
      final response = client != null
          ? await client!.delete(
              Uri.https(Utils.mainUrl.substring(8), 'deletarTreino', params),
            )
          : await http.delete(
              Uri.https(Utils.mainUrl.substring(8), 'deletarTreino', params),
            );

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final responseDecoded = jsonDecode(
              '{"Success": "${response.body}", "statusCode": "${response.statusCode}"}');
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
