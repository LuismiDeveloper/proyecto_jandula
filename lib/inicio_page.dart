import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:proyecto_jandula/convivencia_page.dart';
import 'package:proyecto_jandula/listadoCursos_page.dart';
import 'package:proyecto_jandula/listadoProfesor_page.dart';
import 'package:proyecto_jandula/login_page.dart';
import 'package:proyecto_jandula/sign_in.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flip_card/flip_card.dart';
import 'package:intl/intl.dart';
import 'listado_firestore.dart';
import 'listado_usuario.dart';


final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
//firebase
final databaseReference = FirebaseDatabase.instance.reference();
final _firebaseRef = FirebaseDatabase().reference();
var referencia = _firebaseRef.child("asistencia").push().path;
String clave = referencia.substring(referencia.indexOf("-"));
//firebase

final databaseReferencef = Firestore.instance;
DocumentReference ref;
String myId;
//localizacion
var longitude;
var latitude;


class InicioPage extends StatefulWidget {
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
      ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
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
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      size: 25,
                      color: Colors.lightBlue,
                    ),
                    Text(
                      googleSignIn.currentUser.displayName,
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
          Container()
        ],
      ),
    );
  }
}

// Menú inferior de navegación
Widget menuInferior() {
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
Widget tablaBotones(BuildContext context) {
  return Table(
    children: [
      TableRow(children: [
        cartaAsistencia(context),
        buttonProfesor(context),
        buttonConvivencia(context),
      ]),
      TableRow(children: [
        buttonCursos(context),
        buttonListadoAsistencia(context),
        buttonSalir(context),
      ])
    ],
  );
}

// Botón de asistencia del profesorado
Widget buttonAsistencia() {
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
Widget buttonProfesor(BuildContext context) {
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
Widget buttonConvivencia(BuildContext context) {
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConvivenciaPage()),
            );
          },
        ),
      ),
      Text('Convivencia')
    ],
  );
}

Widget buttonCursos(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.room),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Localiza un curso',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListadoCursosPage()),
            );
          },
        ),
      ),
      Text('Búsq. cursos')
    ],
  );
}

Widget buttonSalir(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Cerrar sesión y salir',
          onPressed: () {
            cerrarSesionGoogle();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ),
      Text('Salir'),
    ],
  );
}

// Botones sin funcionalidad para rellenar la tabla
Widget buttonListadoAsistencia(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(10),
        child: IconButton(
          icon: Icon(Icons.library_books),
          color: Colors.lightBlue,
          iconSize: 50,
          tooltip: 'Nada',
          onPressed: () {
            // if (email == "rafael.delgado.cubilla@iesjandula.es") {
            if (email == "nitreer95@gmail.com") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(),
                ),
              );
              //se retrasa la carga para no producir erores.
              Future.delayed(const Duration(milliseconds: 1000), () {

                Navigator.pop(context);
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListUser(),
                ),
              );
            }
          },
        ),
      ),
      Text('List. asistencia')
    ],
  );
}

// Logo de IES Jándula
Widget imagenJandula() {
  return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage("assets/jandula_logo2.png"), height: 150),
        ],
      ));
}

Widget cartaAsistencia(BuildContext context){
  return FlipCard(
    key: cardKey,
    flipOnTouch: false,
    front: GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: Text(
              'Asistencia',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            //firebase
            //  _firebaseRef.child("asistencia").child(clave).set({
            //                          "Apellidos": apellidos,
            //                          "Nombre": name,
            //                          "fecha_inicio": new DateFormat('yyyy-MM-dd – kk:mm')
            //                              .format(DateTime.now()),
            //                          "fecha_fin": new DateFormat('yyyy-MM-dd – kk:mm')
            //                              .format(DateTime.now())
            //                        });
            //localización

            loca();
            //firebase

            createRecord();
            cardKey.currentState.toggleCard();
          },
        ).show();
      },
      child: new Card(
        color: Colors.green,
        child: new Container(
          padding: new EdgeInsets.all(13.0),
          child: new Column(
            children: <Widget>[
              new Text('Asistencia'),
              SizedBox(height: 30),
              Icon(Icons.verified_user)
            ],
          ),
        ),
      ),
    ),
    back: GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: Center(
            child: Text(
              'Liberar Asistencia',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          tittle: 'This is Ignored',
          desc: 'This is also Ignored',
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            updateData();
            //firebase
            // _firebaseRef.child("asistencia").child(clave).update({
            //                          "fecha_fin": new DateFormat('yyyy-MM-dd – kk:mm')
            //                              .format(DateTime.now())
            //                        });
            //firebase
            //generarclave();
            cardKey.currentState.toggleCard();
          },
        ).show();
      },
      child: new Card(
        color: Colors.red,
        child: new Container(
          padding: new EdgeInsets.all(13.0),
          child: new Column(
            children: <Widget>[
              new Text('Dejar Asistencia'),
              SizedBox(height: 30),
              Icon(Icons.next_week)
            ],
          ),
        ),
      ),
    ),
  );
}

//funciones firestore
void loca() async {
  Location location = new Location();
  location.requestPermission();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
  _locationData = await location.getLocation();
  location.onLocationChanged.listen((LocationData currentLocation) {
    // Use current location
  });
  location.requestPermission();
  longitude = _locationData.longitude;
  latitude = _locationData.latitude;
  print(longitude + " " + latitude);
}

void createRecord() async {
//  final AndroidIntent intent = new AndroidIntent(
//    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
//  );
//  await intent.launch();
//  final Geolocator geolocation = Geolocator()
//    ..forceAndroidLocationManager = true;
//
//  GeolocationStatus geolocationStatus =
//  await geolocation.checkGeolocationPermissionStatus();
//
//  geolocation
//      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//      .then((Position position) {
//    longitude = "${position.latitude}";
//    latitude = "${position.longitude}";
//    print(longitude + "  " + latitude);
//  }).catchError((e) {
//    print(e);
//  });

  ref = await databaseReferencef.collection("Asistencia").add({
    "Apellidos": apellidos,
    "Nombre": name,
    "Fecha_inicio": new DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    "Fecha_fin": new DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    "Latitud": latitude,
    "Longitud": longitude
  });
}

void updateData() {
  myId = ref.documentID;
  try {
    databaseReferencef.collection('Asistencia').document(myId).updateData({
      "Fecha_fin": new DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      "Latitud": latitude,
      "Longitud": longitude
    });
  } catch (e) {
    print(e.toString());
  }
}