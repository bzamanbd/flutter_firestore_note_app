import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: ListView(
            children: [
              Card(
                color: Colors.teal,
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  horizontal: size.width/40,
                  vertical: size.height/40
                ),
                child: ListTile(
                  title: const Text(
                    'This is a Title',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'This is a subtitle',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width/20,
                    vertical: size.height/250,
                  ),
                  onTap: ()=>Navigator.pushNamed(context, '/editnote'),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/addnote'),
          child: const Icon(
            Icons.note_add,
            color: Colors.white,
          ),
          mini: true,
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
