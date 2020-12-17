
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto_jandula/listadoAulaMayoresCursos_page.dart';
import 'package:proyecto_jandula/listadoExpulsadoCursos_page.dart';

class ConvivenciaPage extends StatefulWidget {
  @override
  _ConvivenciaPageState createState() => _ConvivenciaPageState();

}

void main() => runApp(ConvivenciaPage());

class _ConvivenciaPageState extends State<ConvivenciaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Convivencia"),
      ),
      body: Center(
        child: tablaBotones(context),
      ),
    );
  }

}


Widget tablaBotones(BuildContext context){
  return Table(

    children: [
      TableRow(children: [
        buttonExpulsado(context),
        buttonAulaMayores(context)
      ]),
    ],
  );
}

Widget buttonExpulsado(BuildContext context){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.clear),
          color: Colors.red,
          iconSize: 50,
          tooltip: 'Alumnado expulsado',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListadoExpulsadoCursosPage()),
            );
          },
        ),
      ),
      Text('Alum. Expulsado')
    ],
  );
}

Widget buttonAulaMayores(BuildContext context){
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.airline_seat_recline_normal),
          color: Colors.teal,
          iconSize: 50,
          tooltip: 'Alumnado en Aula de Mayores',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListadoAulaMayoresCursosPage()),
            );
          },
        ),
      ),
      Text('Aula de Mayores')
    ],
  );
}