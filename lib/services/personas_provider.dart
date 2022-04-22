import 'dart:convert';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';

class PersonaProvider {
  final _prefs = PreferenciasUsuario();

  Future<List<PersonModel>> cargarPersonas() async {

    final token = _prefs.token;

    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('GET', Uri.parse('http://hiring.medvision.com.co/api/Person/GetAllPeople'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final decodedData = json.decode(await response.stream.bytesToString());
    print(decodedData);

    final List<PersonModel> personas = [];
    if (decodedData == null) return [];

    decodedData.forEach((prod) {
      final prodTemp = PersonModel.fromJson(prod);
      personas.add(prodTemp);
    });

    if (response.statusCode == 200) {
      print('ok');
    }
    else {
      print(response.reasonPhrase);
    }

    return personas;

  }

}