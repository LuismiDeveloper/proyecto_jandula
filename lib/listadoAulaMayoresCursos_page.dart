import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto_jandula/listadoAulaMayoresAlumnos_page.dart';



// Almacena los datos del JSON en una lista
List listaDatos = List();

// Esta lista servirá para almacenar los datos del profesor seleccionado
List listaDatosSeleccionado = List();

// Almacena los nombres de los profesores que dan clase en el día actual
List listaCursos = List();

// Nos servirá para recoger el nombre seleccionado en el ListView
String seleccionado;

class ListadoAulaMayoresCursosPage extends StatefulWidget {
  @override
  _ListadoAulaMayoresCursosPageState createState() => _ListadoAulaMayoresCursosPageState();

}

void main() => runApp(ListadoAulaMayoresCursosPage());

class _ListadoAulaMayoresCursosPageState extends State<ListadoAulaMayoresCursosPage> {

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
    final String hoja = 'convivencia';
    // Obtengo el JSON a través de la ejecución del Google App Script
    final response = await http.get(
        'https://script.google.com/macros/s/AKfycbyB7-qCXuP54-9IsOgV62OuIFluzeZ3h_pj54CaQrUAwKgeZtOH/exec?spreadsheetId=$sheetID&sheet=$hoja');

    setState(() {
      listaDatos = json.decode(response.body);

      // Elimino los que no sean del tipo expulsados
      listaDatos.removeWhere((item) => item['Tipo'] != 'Aula Mayores');

      // Elimino los datos que no estén dentro del rango de fechas
      listaDatos.removeWhere((item) => isDentro(item['Fecha Inicio'], item['Fecha Fin']) == false);

      // Paso los cursos a la listaProfesores
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
        title: Text("Cursos con alum. en Aula de Mayores"),
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
                  MaterialPageRoute(builder: (context) => ListadoAulaMayoresAlumnosPage()),
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
// Sheet: convivencia
class Datos {
  final String alumno;
  final String curso;
  final String f_inicio;
  final String f_fin;
  final String tipo;

  Datos({this.alumno, this.curso, this.f_inicio, this.f_fin, this.tipo});

  factory Datos.fromJson(Map<String, dynamic> json) {
    return Datos(
        alumno: json['Alumno'],
        curso: json['Curso'],
        f_inicio: json['Fecha Inicio'],
        f_fin: json['Fecha Fin'],
        tipo: json['Tipo']);
  }
}

// Clase para almacenar objetos en una lista de tipo Datos
// Sheet: convivencia
class ListaDatos {
  final List<Datos> datos;

  ListaDatos({this.datos});

  factory ListaDatos.fromJson(List<dynamic> json) {
    List<Datos> datos = new List<Datos>();
    datos = json.map((i) => Datos.fromJson(i)).toList();

    return new ListaDatos(datos: datos);
  }
}

// Método para saber si la fecha actual está dentro del rango de las fechas del sheet
bool isDentro(String f_inicio, String f_fin){

  bool dentro;

  // Conversión de las fechas a DateTime
  // Divimos la fecha en 3 partes, es decir, en dia, mes y año
  List<String> f_inicioValues = f_inicio.split('/');
  List<String> f_finValues = f_fin.split('/');

  // Construimos el DateTime pasandole año, mes y día en ese orden
  DateTime dateInicio = DateTime.utc(int.parse(f_inicioValues[2]), int.parse(f_inicioValues[1]), int.parse(f_inicioValues[0]));
  DateTime dateFin = DateTime.utc(int.parse(f_finValues[2]), int.parse(f_finValues[1]), int.parse(f_finValues[0]));


  if((dateInicio.isBefore(DateTime.now()) && dateFin.isAfter(DateTime.now())) || (dateInicio == DateTime.now()) || (dateFin == DateTime.now())){
    dentro = true;
  } else {
    dentro = false;
  }

  return dentro;

}