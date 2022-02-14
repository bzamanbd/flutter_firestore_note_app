import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firestore_note_app/screens/login_screen.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String _title = 'Email Auth';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink
      ),
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return HomeScreen(snapshot.data);
          }
          return  const LoginScreen();
        },
      ),
    );
  }
}
