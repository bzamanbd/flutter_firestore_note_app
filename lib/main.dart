import 'package:firebase_core/firebase_core.dart';
import '../screens/login_screen.dart';
import '../screens/upload_image.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';
// import 'screens/home_screen.dart';

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
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.pink),
      home: StreamBuilder(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            ///use homscreen to view the user's notes//
            // return HomeScreen(snapshot.data);

            ///use uploadimagescreen to fetch images from cloudStorage
            return const UploadImageScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
