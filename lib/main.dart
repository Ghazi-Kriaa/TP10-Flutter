import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants/strings.dart';
import 'presentation/screens/home.dart';
import './presentation/app_router.dart';
String initialRoute='/';
void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
//faire le test si utilisateur est déjà connecté passer directement à mapScreen sinon le screen loginScreen sera affiché
 FirebaseAuth.instance.authStateChanges().listen((user) {
 if (user == null) {
 initialRoute = loginScreen;
 } else {
 initialRoute = mapScreen;
 }
 });
AppRouter appRouter = AppRouter() ;
 runApp(
 MaterialApp(
 title: 'Flutter Application Map',
 debugShowCheckedModeBanner: false,
 theme: ThemeData(
 primarySwatch: Colors.blue,
 ),
 initialRoute: initialRoute,
 onGenerateRoute: appRouter.generateRoute,
 home: const MyApp(),
 ),
 );
}
class MyApp extends StatelessWidget {
 const MyApp({Key? key}) : super(key: key);
@override
 Widget build(BuildContext context) {
 return Scaffold(
 appBar: AppBar(
 title: const Text('Application Flutter'),
 backgroundColor: Colors.blue[700],
 ),
 body : const Home(),
 );
 }
} 