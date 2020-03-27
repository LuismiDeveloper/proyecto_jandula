import 'package:flutter/material.dart';
import 'package:proyecto_jandula/inicio_page.dart';
import 'package:proyecto_jandula/sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

// Diseño de la pantalla, contiene una imagen y un botón
class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/jandula_logo.png"), height: 250,),
              SizedBox(height: 50),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  // Diseño y función del botón de inicio de sesión
  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: (){
        iniciarConGoogle().whenComplete((){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return PaginaInicio();
              }
            )
          );
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),

    );
  }

}



