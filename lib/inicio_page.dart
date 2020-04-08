import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_jandula/listadoProfesor_page.dart';
import 'package:proyecto_jandula/sign_in.dart';
import 'package:firebase_admob/firebase_admob.dart';

class InicioPage extends StatefulWidget{
  @override
  _InicioPageState createState() => _InicioPageState();

}


class _InicioPageState extends State<InicioPage> {
  MobileAdTargetingInfo targetingInfo;
  BannerAd myBanner;

  @override
  void initState() {
    super.initState();

    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      //birthday: DateTime.now(),
      childDirected: false,
      //designedForFamilies: false,
      //gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );

    myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.fullBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    showBanner();
  }

  void showBanner() {
    myBanner
    ..load()
    ..show(
      anchorOffset: 0.0,
      anchorType: AnchorType.bottom
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                  border: Border.all(color: Colors.lightBlue, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(30))
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
          ),
          Container(

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
          onPressed: () { cerrarSesionGoogle(); },
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

