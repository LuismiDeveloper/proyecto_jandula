import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Creamos instancias de FireBase Authentication y Google Sign In
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();


String name;
String apellidos;
String email;
String imageUrl;

// Método para iniciar sesión con Google
Future<String> iniciarConGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  // Obtenemos la credencial de sesión
  final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
  );

  final AuthResult authResult = await firebaseAuth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;


  // Comprobaciones previas antes de iniciar la sesión
  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  // Obtenemos nombre y apellidos
  if (name.contains(" ")) {
    apellidos = name.substring(name.indexOf(" ") + 1);
    name = name.substring(0, name.indexOf(" "));
  }

  final FirebaseUser usuarioActual = await firebaseAuth.currentUser();
  assert(user.uid == usuarioActual.uid);



  // Si tódo está correcto se iniciará la sesión sin problemas
  return 'Sesión iniciada correctamente: $user';
}

// Método para cerrar la sesión
void cerrarSesionGoogle() async {
  await googleSignIn.signOut();

  print("Sesión cerrada");
}

