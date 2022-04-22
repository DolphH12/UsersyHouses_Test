import 'package:flutter/material.dart';
import 'package:flutter_application_1/animation/fade_animation.dart';
import 'package:flutter_application_1/user_preferences/preferencias_usuario.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../services/usuario_provider.dart';


class LoginPage extends StatelessWidget {
  String usuario = '';
  String password = '';
  UsuarioProvider usuarioProvider = UsuarioProvider();
  final PreferenciasUsuario _prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, 'welcome');
        return false;
      },
      child: ProgressHUD(
        backgroundColor: Colors.green[900]!,
        textStyle: TextStyle(color: Colors.black, fontSize: 18),
        child: Builder(
          builder: (context) => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'welcome');
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.black,
                ),
              ),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  'Ingresar',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1.2,
                                Text(
                                  'Ingresa con tu cuenta',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[700]),
                                )),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: <Widget>[
                              FadeAnimation(
                                  1.2, makeInput(label: 'Usuario', t: 0)),
                              FadeAnimation(
                                  1.3,
                                  makeInput(
                                      label: 'Contraseña',
                                      obscureText: true,
                                      t: 1)),
                            ],
                          ),
                        ),
                        FadeAnimation(
                            1.4,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                padding: EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                    )),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () {
                                    final progress = ProgressHUD.of(context);
                                    _onSubmit(context);
                                    progress!.show();
                                    Future.delayed(Duration(seconds: 5), () {
                                      progress.dismiss();
                                    });
                                  },
                                  color: Colors.green,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    'Ingresar',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  FadeAnimation(
                      1.2,
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/image_p2.png'),
                                fit: BoxFit.cover)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obscureText = false, t = 0}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          onChanged: (value) {
            switch (t) {
              case 0:
                usuario = value;
                break;
              case 1:
                password = value;
                break;
              default:
            }
          },
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  void _onSubmit(BuildContext context) async {
    Map info = {};
    try {
      info = await usuarioProvider.login(usuario, password);
    } catch (e) {
      info['ok'] = false;
    }

    if (info['ok']) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacementNamed(context, 'home');
      });
    }
  }
}