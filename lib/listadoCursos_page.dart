import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'listadoCursosHoras_page.dart';



// Almacena los datos del JSON en una lista
List listaDatos = List();

// Esta lista servirá para almacenar los datos del curso seleccionado
List listaDatosSeleccionado = List();

// Almacena solamente los cursos
List listaCursos = List();

// Nos servirá para recoger el curso seleccionado en el ListView
String seleccionado;

class ListadoCursosPage extends StatefulWidget {
  @override
  _ListadoCursosPageState createState() => _ListadoCursosPageState();

}

void main() => runApp(ListadoCursosPage());

class _ListadoCursosPageState extends State<ListadoCursosPage> {

  // HashSet servirá para eliminar los valores duplicados
  HashSet hs = new HashSet();


  @override
  void initState() {
    super.initState();
    this.obtenerDatos();

  }



  // Metodo para obtener los datos y pasarlos a lista
  Future<ListaDatos> obtenerDatos() async {
    final String sheetID = '1ibBxNJQKJPbcrK789nRf5sB-y6QMgppNm2NT4Z_viso';
    final String hoja = 'cursos';
    // Obtengo el JSON a través de la ejecución del Google App Script
    final response = await http.get(
        'https://script.google.com/macros/s/AKfycbyB7-qCXuP54-9IsOgV62OuIFluzeZ3h_pj54CaQrUAwKgeZtOH/exec?spreadsheetId=$sheetID&sheet=$hoja');

    setState(() {
      listaDatos = json.decode(response.body);


      // Paso solo los cursos a la listaCursos
      for(int i = 0; i < listaDatos.length; i++){
        listaCursos.add(listaDatos[i]['Curso']);
      }

      // Proceso para eliminar los cursos duplicados con HasShet
      hs.addAll(listaCursos);
      listaCursos.clear();
      listaCursos.addAll(hs);

      // Ordenamos la lista
      listaCursos.sort();

    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de cursos"),
      ),

      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: listaCursos == null ? 0 : listaCursos.length,
          itemBuilder: (BuildContext context, int index) {
            return OutlineButton(
              disabledBorderColor: Colors.lightBlue,
              disabledTextColor: Colors.black,
              child: Text(listaCursos[index]),
              onPressed: (){

                seleccionado = listaCursos[index];
                listaDatosSeleccionado.clear();
                listaDatosSeleccionado.addAll(listaDatos);
                listaDatosSeleccionado.removeWhere((item) => item['Curso'] != seleccionado);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListadoCursosHorasPage()),
                );

              },
            );
          }),

    );


    /*
    return new MaterialApp(
      home: Scaffold(
          bottomNavigationBar: menuInferior(),
          body: ListView.builder(
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
// Sheet: cursos
class Datos {
  final String curso;
  final String hora;
  final String aula;


  Datos({this.curso, this.hora, this.aula});

  factory Datos.fromJson(Map<String, dynamic> json) {
    return Datos(
        curso: json['Curso'],
        hora: json['Hora'],
        aula: json['Aula']);
  }
}

// Clase para almacenar objetos en una lista de tipo Datos
// Sheet: cursos
class ListaDatos {
  final List<Datos> datos;

  ListaDatos({this.datos});

  factory ListaDatos.fromJson(List<dynamic> json) {
    List<Datos> datos = new List<Datos>();
    datos = json.map((i) => Datos.fromJson(i)).toList();

    return new ListaDatos(datos: datos);
  }
}

