import 'package:flutter/material.dart';
import 'package:proyecto_jandula/inicio_page.dart';
import 'package:proyecto_jandula/sign_in.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();

}

// Diseño de la pantalla, contiene una imagen y un botón
class _LoginPageState extends State<LoginPage> {

  List listaUsuarios = List();

  @override
  void initState() {
    super.initState();
  }


  Future<ListaUsuarios> obtenerUsuarios() async {
    final String sheetID = '1ibBxNJQKJPbcrK789nRf5sB-y6QMgppNm2NT4Z_viso';
    final String hoja = 'usuarios';
    // Obtengo el JSON a través de la ejecución del Google App Script
    final response = await http.get(
        'https://script.google.com/macros/s/AKfycbyB7-qCXuP54-9IsOgV62OuIFluzeZ3h_pj54CaQrUAwKgeZtOH/exec?spreadsheetId=$sheetID&sheet=$hoja');

    setState(() {
      listaUsuarios = json.decode(response.body);
    });

  }
  
  
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

          obtenerUsuarios().whenComplete((){
            print(listaUsuarios);
            // Borro de la lista todos los emails que no sean el escogido por el usuario
            listaUsuarios.removeWhere((item) => item['Email'] != googleSignIn.currentUser.email);
            print('Cuenta: '+googleSignIn.currentUser.email);


            // Si la lista se queda vacía quiere decir que ese email no está registrado
            if(listaUsuarios.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: Text('La cuenta elegida no tiene acceso a la aplicación. Aseguresé de tener su cuenta @iesjandula.es vinculada al dispositivo.'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('Entendido'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
              );

              cerrarSesionGoogle();

            } else {

              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {
                        return InicioPage();
                      }
                  )
              );

            }
          });

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

// Clase para modelar los datos recibidos del JSON
// Sheet: usuarios
class Usuarios {
  final String email;

  Usuarios({this.email});

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
        email: json['Email']
    );
  }
}

// Clase para almacenar objetos en una lista de tipo Usuarios
// Sheet: usuarios
class ListaUsuarios {
  final List<Usuarios> usuarios;

  ListaUsuarios({this.usuarios});

  factory ListaUsuarios.fromJson(List<dynamic> json) {
    List<Usuarios> usuarios = new List<Usuarios>();
    usuarios = json.map((i) => Usuarios.fromJson(i)).toList();

    return new ListaUsuarios(usuarios: usuarios);
  }
}
