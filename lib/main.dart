import 'package:flutter/material.dart';

import 'screens/addnote_screen.dart';
import 'screens/edit_note_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final String _title = 'NoteApp';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
      ),
      home: HomeScreen(title: _title,),
      routes: {
        '/home':(_)=>HomeScreen(title: _title),
        '/addnote':(_)=>const AddNoteScreen(),
        '/editnote':(_)=>const EditNoteScreen(),
      },
    );
  }
}
