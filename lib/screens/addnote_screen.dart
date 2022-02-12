import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width/15,
              vertical: size.height/30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Title',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height/60,),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 4,
                ),
                SizedBox(height: size.height/20,),
                const Text(
                  'Description',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height/60,),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  minLines: 5,
                  maxLines: 10,
                ),
                SizedBox(height: size.height/30,),
                SizedBox(
                  width: size.width,
                  height: size.height/10,
                  child: ElevatedButton(
                    onPressed: (){},
                    child:  const Text('Add Note',
                    style: TextStyle(
                      fontSize: 19
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      )

                      )
                      ),

                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
