import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginaProfesor extends StatefulWidget {
  @override
  _PaginaProfesorState createState() => _PaginaProfesorState();
}

void main() => runApp(PaginaProfesor());

class _PaginaProfesorState extends State<PaginaProfesor> {
  // Almacenan los datos de los JSON en listas
  List listaDatos = List();
  List listaProfesores = List();

  // Almacena los profesores que dan clase en el día actual
  List profesores = List();

  // HashSet servirá para eliminar los valores duplicados
  HashSet hs = new HashSet();


  @override
  void initState() {
    super.initState();
    this.obtenerDatos();

  }

  // Convertir respuesta HTTP a Datos
  Future<ListaDatos> obtenerDatos() async {
    final String sheetID = '1ibBxNJQKJPbcrK789nRf5sB-y6QMgppNm2NT4Z_viso';
    final String hoja = 'busqueda';
    // Obtengo el JSON a través de la ejecución del Google App Script
    final response = await http.get(
        'https://script.google.com/macros/s/AKfycbyB7-qCXuP54-9IsOgV62OuIFluzeZ3h_pj54CaQrUAwKgeZtOH/exec?spreadsheetId=$sheetID&sheet=$hoja');

    setState(() {
      listaDatos = json.decode(response.body);

      // Elimino los datos que no pertenezcan al día de hoy
      listaDatos.removeWhere((item) => item['Dia'] != getDiaSemana(DateTime.now()));

      // Paso los nombres de los profesores a la listaProfesores
      for(int i = 0; i < listaDatos.length; i++){
        listaProfesores.add(listaDatos[i]['Profesor']);
      }

      // Proceso para eliminar los profesores duplicados con HasShet
      hs.addAll(listaProfesores);
      listaProfesores.clear();
      listaProfesores.addAll(hs);

      // Ordenamos la lista
      listaProfesores.sort();

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de profesores"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: listaProfesores == null ? 0 : listaProfesores.length,
          itemBuilder: (BuildContext context, int index) {
            return OutlineButton(
                  disabledBorderColor: Colors.lightBlue,
                  disabledTextColor: Colors.black,
                  child: Text(listaProfesores[index]),
                  onPressed: (){

                  },
            );
          }),
    );


    /*
    return new MaterialApp(
      home: Scaffold(
          bottomNavigationBar: menuInferior(),
          body: Center(
            child: FutureBuilder<ListaDatos>(
              future: futureDatos,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Text(snapshot.data.datos[0].profesor);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          )),
    );

     */
  }

}

// Clase para modelar los datos recibidos del JSON
// Sheet: busqueda
class Datos {
  final String dia;
  final String profesor;
  final String aula;
  final String hora;

  Datos({this.dia, this.profesor, this.aula, this.hora});

  factory Datos.fromJson(Map<String, dynamic> json) {
    return Datos(
        dia: json['Dia'],
        profesor: json['Profesor'],
        aula: json['Aula'],
        hora: json['Hora']);
  }
}

// Clase para almacenar objetos en una lista de tipo Datos
// Sheet: busqueda
class ListaDatos {
  final List<Datos> datos;

  ListaDatos({this.datos});

  factory ListaDatos.fromJson(List<dynamic> json) {
    List<Datos> datos = new List<Datos>();
    datos = json.map((i) => Datos.fromJson(i)).toList();

    return new ListaDatos(datos: datos);
  }
}

// Clase para modelar los datos recibidos del JSON
// Sheet: profesores
class Profesor {
  final String nombre;

  Profesor({this.nombre});

  factory Profesor.fromJson(Map<String, dynamic> json) {
    return Profesor(
      nombre: json['Nombre']
    );
  }
}

// Clase para almacenar objetos en una lista de tipo Profesor
// Sheet: profesores
class ListaProfesores {
  final List<Profesor> profesores;

  ListaProfesores({this.profesores});

  factory ListaProfesores.fromJson(List<dynamic> json){
    List<Profesor> profesores = new List<Profesor>();
    profesores = json.map((i) => Profesor.fromJson(i)).toList();

    return new ListaProfesores(profesores: profesores);
  }
}

// Método para obtener el dia de la semana
// Le pasamos por parámetro la fecha actual
String getDiaSemana(DateTime fechaAct){
  String diaSemana;

  switch(fechaAct.weekday){
    case 1:
      diaSemana = 'lunes';
      break;

    case 2:
      diaSemana = 'martes';
      break;

    case 3:
      diaSemana = 'miercoles';
      break;

    case 4:
      diaSemana = 'jueves';
      break;

    case 5:
      diaSemana = 'viernes';
      break;

    default:
      diaSemana = 'no lectivo';
      break;
  }

  return diaSemana;
}

