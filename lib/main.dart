import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/casa_page.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/user_page.dart';
import 'package:flutter_application_1/pages/welcome.dart';
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'welcome',
      routes: {
        'home': (context) => HomePage(),
        'welcome':(context) => WelcomePage(),
        'login':(context) => LoginPage(),
        'persona':(context) => UserPage(),
        'casa':(context) => CasaPage(),
      },
    );
  }
}