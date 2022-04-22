import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/services/personas_provider.dart';
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, 'home');
        return false;
      },
      child: Scaffold(
        floatingActionButton: GFButton(
          onPressed: () {
            //showDialog(context: context, builder: (_) => CustomEventDialog());
          },
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          text: "Añadir Casa",
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          size: 50,
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          color: Colors.green[900]!,
          shape: GFButtonShape.pills,
        ),
        appBar: AppBar(
            backgroundColor: Colors.green[700],
            title: Text(persona.firstName.toUpperCase()),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushNamed(context, 'home');
              },
            ),
            
          ),
        body: Stack(
          children: [
            const FondoApp(),
            _perfilUser(persona)
          ],
        ),
      ),
    );
  }

  Widget _perfilUser(PersonModel persona){
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
                  child: Image(image: AssetImage('assets/user.png'))),
                SizedBox(height: 20,),
                Text("${persona.firstName} ${persona.lastName}", style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text('CC. ${persona.document}', style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),),
                SizedBox(height: 10,),
                Text('Nacimiento: ${persona.birthDate}', style: TextStyle(fontSize: 20, color: Colors.black, decoration: TextDecoration.none),)
              ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        GFButton(
          onPressed: (){
            Navigator.pushNamed(context, 'casa',
              arguments: persona);
          },
          text: "Ver Casa",
          shape: GFButtonShape.pills,
          fullWidthButton: true,
          blockButton: true,
          size: 50,
          textStyle: TextStyle(fontSize: 20),
          color: Colors.green[700]!,
      ),
      ],
    );
  }
}