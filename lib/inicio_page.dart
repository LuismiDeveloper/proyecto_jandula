import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_jandula/listadoProfesor_page.dart';
import 'package:proyecto_jandula/sign_in.dart';

class PaginaInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: menuInferior(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Center(
              child: imagenJandula(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlue, width: 5)
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person, size: 25, color: Colors.lightBlue,),
                    Text(googleSignIn.currentUser.displayName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,

                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.blue,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],

                          ),
                    ),
                  ],
                ),
              )
            ],
          ),

          Container(
            child: Center(
              child: tablaBotones(context),
            ),
          )
        ],
      ),

    );
  }

}


// Menú inferior de navegación
Widget menuInferior(){
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Inicio'),
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        title: Text('Agenda'),
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        title: Text('Menú'),
      ),
    ],
  );
}

// Tabla con los diferentes botones
Widget tablaBotones(BuildContext context){
  return Table(
    children: [
      TableRow(children: [
        buttonAsistencia(),
        buttonProfesor(context),
        buttonConvivencia(),
      ]),
      TableRow(children: [
        buttonNada(),
        buttonNada(),
        buttonNada(),
      ])
    ],
  );
}


// Botón de asistencia del profesorado
Widget buttonAsistencia(){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.done_outline),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Registra tu entrada al centro',
          onPressed: () {},
        ),
      ),
      Text('Asistencia')
    ],
  );
}


// Botón para saber el aula donde se encuentra el profesorado
Widget buttonProfesor(BuildContext context){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.search),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Comprueba donde se encuentra actualmente un profesor',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListadoProfesorPage()),
            );
          },
        ),
      ),
      Text('Búsq. profesor')
    ],
  );
}


// Botón para comprobar los alumnos expulsados o en aula de mayores
Widget buttonConvivencia(){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.face),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Alumnado apartado de clase',
          onPressed: () {},
        ),
      ),
      Text('Convivencia')
    ],
  );
}


// Botones sin funcionalidad para rellenar la tabla
Widget buttonNada(){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.help),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Nada',
          onPressed: () {},
        ),
      ),
      Text('En proceso')
    ],
  );
}


// Logo de IES Jándula
Widget imagenJandula(){
  return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage("assets/jandula_logo2.png"), height: 150),
        ],
      )
  );
}