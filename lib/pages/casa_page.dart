import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/services/personas_provider.dart';
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

class CasaPage extends StatefulWidget {
  CasaPage({Key? key}) : super(key: key);

  @override
  State<CasaPage> createState() => _CasaPageState();
}

class _CasaPageState extends State<CasaPage> {
  final personasProvider = PersonaProvider();
  final _prefs = PreferenciasUsuario();

  late PersonModel persona;

  @override
  Widget build(BuildContext context) {
    final prodData = ModalRoute.of(context)?.settings.arguments;
    if (prodData != null) {
      final persona_temp = jsonEncode(prodData);
      persona = personModelFromJson(persona_temp);
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text(persona.firstName.toUpperCase()),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          
        ),
      body: Stack(
        children: [
          const FondoApp(),
          _perfilCasa(persona)
        ],
      ),
    );
  }

  Widget _perfilCasa(PersonModel persona){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 400,
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Image(image: AssetImage('assets/casa.png'))),
                SizedBox(height: 20,),
                Text(persona.houses.isEmpty ? "Esta persona no tiene casa" : "${persona.houses[0].description}", style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text(persona.houses.isEmpty ? "-" : 'Addres. ${persona.houses[0].address}', style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text(persona.houses.isEmpty ? "-" : 'Owner: ${persona.firstName}', style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),)
              ],
            ),
          ),
        ),
      ],
    );
  }
}