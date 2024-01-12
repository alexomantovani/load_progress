import 'dart:convert';

import 'package:load_progress/models/workout/workout.dart';

import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class WorkoutService {
  Future<Map<String,dynamic>?> createWorkout(String email, String tipoTreino, List<Map<String, dynamic>> exercicios) async {
    final body = {
      "email": email,
      "tipoTreino": tipoTreino,
      "exercicios": exercicios.toString(),
    };

    try {
      final response = await http.post(Uri.parse('${Utils.mainUrl}/criarTreino'), body: body);
      final responseDecoded = await jsonDecode(response.body);
      print('UserService Response: $responseDecoded, statuscode: ${response.statusCode}');

      if(response.statusCode == 201) {
        if(responseDecoded != null) {
          return responseDecoded;
        } else {
          return {"Error": "The response.body is null"};
        }
      } else {
        return responseDecoded;
      }
    } catch (e) {
      print('Error: $e');
      return {'Error': e.toString()};
    }
  }

  Future<List<Workout?>?> listWorkouts(String usuarioId) async {
    final params = {
      "usuarioId": usuarioId
    };

    try {
      final response = await http.get(Uri.https(Utils.mainUrl.substring(8), '/listarTreinosDoUsuario', params));
      final responseDecoded = await jsonDecode(response.body) as List;
      print('UserService Response: $responseDecoded, statuscode: ${response.statusCode}');

      final workouts = responseDecoded.map((e) => Workout.fromMap(e)).toList();
      
      return workouts;
    } catch (e) {
      print("Error catch: $e");
      return null;
    }
  }
}