import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginaProfesor extends StatefulWidget {
  @override
  _PaginaProfesorState createState() => _PaginaProfesorState();
}

void main() => runApp(PaginaProfesor());

class _PaginaProfesorState extends State<PaginaProfesor> {
  List data;

  @override
  void initState() {
    super.initState();
    this.obtenerDatos();

  }

  // Convertir respuesta HTTP a Datos
  Future<ListaDatos> obtenerDatos() async {
    final String sheetID = '1ibBxNJQKJPbcrK789nRf5sB-y6QMgppNm2NT4Z_viso';
    final String hoja = 'profesores';
    // Obtengo el JSON a través de la ejecución del Google App Script
    final response = await http.get(
        'https://script.google.com/macros/s/AKfycbyB7-qCXuP54-9IsOgV62OuIFluzeZ3h_pj54CaQrUAwKgeZtOH/exec?spreadsheetId=$sheetID&sheet=$hoja');

    setState(() {
      data = json.decode(response.body);
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de profesores"),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(10),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return OutlineButton(
              disabledBorderColor: Colors.lightBlue,
              disabledTextColor: Colors.black,
              child: Text(data[index]['Nombre']),
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

class ListaDatos {
  final List<Datos> datos;

  ListaDatos({this.datos});

  factory ListaDatos.fromJson(List<dynamic> json) {
    List<Datos> datos = new List<Datos>();
    datos = json.map((i) => Datos.fromJson(i)).toList();

    return new ListaDatos(datos: datos);
  }
}
