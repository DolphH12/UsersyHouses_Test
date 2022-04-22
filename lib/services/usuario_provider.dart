import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';


class UsuarioProvider {
  final _prefs = PreferenciasUsuario();
  final ip = 'hiring.medvision.com.co';

  Future<Map<String, dynamic>> login(String usuario, String password) async {

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('http://hiring.medvision.com.co/api/Auth'));
    request.body = json.encode({
      "username": usuario,
      "password": password
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final decodedResp = json.decode(await response.stream.bytesToString());

    _prefs.token = decodedResp['token'];
    _prefs.username = usuario;

    print(_prefs.token);

    if (response.statusCode == 200) {
      return {'ok': true};
    }
    else {
      print(response.reasonPhrase);
      return {'ok': false};
    }

  }
}