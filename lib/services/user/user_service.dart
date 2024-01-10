import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:load_progress/utils/utils.dart';

class UserService {
  Future<String> createUser(String name, String email) async {
    final body = {
      "name": name,
      "email": email,
    };

    try {
      final response = await http.post(Uri.parse(Utils.mainUrl),body: body);

      if(response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return jsonDecode(response.body);
      }
    } catch(e) {
      print(e);
      return '$e';
    }
  }
}