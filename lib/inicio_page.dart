import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

          Container(
            child: Center(
              child: tablaBotones(),
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
        icon: Icon(Icons.chat),
        title: Text('Comunicación'),
      ),
    ],
  );
}

// Tabla con los diferentes botones
Widget tablaBotones(){
  return Table(
    children: [
      TableRow(children: [
        buttonAsistencia(),
        buttonProfesor(),
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
Widget buttonProfesor(){
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
          onPressed: () {},
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
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage("assets/jandula_logo2.jpg"), height: 250),
        ],
      )
  );
}