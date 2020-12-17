import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_jandula/listadoExpulsadoCursos_page.dart';


class ListadoExpulsadoAlumnosPage extends StatefulWidget {
  @override
  _ListadoExpulsadoAlumnosPageState createState() => _ListadoExpulsadoAlumnosPageState();
}

void main() => runApp(ListadoExpulsadoAlumnosPage());

class _ListadoExpulsadoAlumnosPageState extends State<ListadoExpulsadoAlumnosPage> {


  @override
  void setState(fn) {
    super.setState(fn);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(seleccionado),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: listaDatosSeleccionado == null ? 0 : listaDatosSeleccionado.length,
          itemBuilder: (BuildContext context, int index) {
            return OutlineButton(
              disabledBorderColor: Colors.lightBlue,
              disabledTextColor: Colors.black,
              child: Text(listaDatosSeleccionado[index]['Alumno']),

            );
          }),
    );
  }


}