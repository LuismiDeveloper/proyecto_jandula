import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_jandula/listadoCursos_page.dart';


class ListadoCursosHorasPage extends StatefulWidget {
  @override
  _ListadoCursosHorasPageState createState() => _ListadoCursosHorasPageState();
}

void main() => runApp(ListadoCursosHorasPage());

class _ListadoCursosHorasPageState extends State<ListadoCursosHorasPage> {


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
              child: Text(listaDatosSeleccionado[index]['Hora']),
              onPressed: (){
                showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        content: Text(seleccionado + ' se encuentra en el Aula '+listaDatosSeleccionado[index]['Aula']),
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

                /*
                Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(seleccionado + ' se encuentra en el Aula '+
                          listaDatosSeleccionado[index]['Aula'] + ' a las '+
                          listaDatosSeleccionado[index]['Hora']),

                      action: SnackBarAction(
                        label: 'Entendido',
                        onPressed: () {},
                      ),
                    )
                );*/
              },
            );
          }),
    );
  }


}