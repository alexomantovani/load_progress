import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:load_progress/models/user/user.dart';
import 'package:load_progress/utils/utils.dart';

class UserService {
  UserService({this.client});

  http.Client? client;

  Future<Map<String, dynamic>?> createUser(String name, String email) async {
    final body = {
      "name": name,
      "email": email,
    };

    try {
      final response = client != null
          ? await client!
              .post(Uri.parse('${Utils.mainUrl}/cadastrarUsuario'), body: body)
          : await http.post(Uri.parse('${Utils.mainUrl}/cadastrarUsuario'),
              body: body);

      final responseDecoded = await jsonDecode(response.body);
      print(
          'UserService Response: $responseDecoded, statuscode: ${response.statusCode}');

      if (response.statusCode == 201) {
        if (responseDecoded != null) {
          return responseDecoded;
        } else {
          return {"Error": "The response.body is null"};
        }
      } else {
        return responseDecoded;
      }
    } catch (e) {
      return {"Error": e.toString()};
    }
  }

  Future<List<User?>?> getUser(String name) async {
    final params = {"nomeCompleto": name};

    try {
      final response = client != null
          ? await client!.get(Uri.https(
              Utils.mainUrl.substring(8), '/obterUsuarioPorNome', params))
          : await http.get(Uri.https(
              Utils.mainUrl.substring(8), '/obterUsuarioPorNome', params));

      final responseDecoded = [await jsonDecode(response.body)];

      final userlist = responseDecoded.map((e) => User.fromMap(e)).toList();
      return userlist;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> updateUser(
      String userId, Map<String, dynamic> body) async {
    final params = {"usuarioId": userId};

    try {
      final response = client != null
          ? await client!.put(
              Uri.https(Utils.mainUrl.substring(8), 'atualizarCadastroUsuario',
                  params),
              body: body)
          : await http.put(Uri.https(
              Utils.mainUrl.substring(8), 'atualizarCadastroUsuario', params));

      final responseDecoded = jsonDecode(response.body);

      return responseDecoded;
    } catch (e) {
      // print("Error: $e");
      return {"Error": e.toString()};
    }
  }

  Future<Map<String, dynamic>?> deleteUser(String userId) async {
    final params = {"usuarioId": userId};

    try {
      final response = client != null
          ? await client!.delete(Uri.https(
              Utils.mainUrl.substring(8), 'deletarCadastroUsuario', params))
          : await http.delete(Uri.https(
              Utils.mainUrl.substring(8), 'deletarCadastroUsuario', params));
              
      final responseDecoded = jsonDecode(response.body);

      return responseDecoded;
    } catch (e) {
      return {"Error": e.toString()};
    }
  }
}
