import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/person_model.dart';
import 'package:flutter_application_1/services/personas_provider.dart';
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:getwidget/getwidget.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final personasProvider = PersonaProvider();
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: GFButton(
          onPressed: () {
            //showDialog(context: context, builder: (_) => CustomEventDialog());
          },
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          text: "Añadir Persona",
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          size: 50,
          icon: Icon(
            Icons.person_add,
            color: Colors.white,
          ),
          color: Colors.green[900]!,
          shape: GFButtonShape.pills,
        ),
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text('PERSONAS'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
          
        ),
        body: Stack(
          children: [
            const FondoApp(),
            _crearListado(),
          ],
        ),
      );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: personasProvider.cargarPersonas(),
      builder:
          (BuildContext context, AsyncSnapshot<List<PersonModel>> snapshot) {
        if (snapshot.hasData) {
          final personas = snapshot.data;

          return ListView.builder(
            itemCount: personas!.length,
            itemBuilder: (context, i) => _crearItem(personas[i])
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(PersonModel persona) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.person),
        trailing: const Icon(Icons.arrow_forward_ios),
        title: Text('${persona.firstName} ${persona.lastName}'),
        subtitle: Text(persona.document),
        onTap: () {
          Navigator.pushNamed(context, 'persona',
              arguments: persona);
      }),
    );
  }

}






