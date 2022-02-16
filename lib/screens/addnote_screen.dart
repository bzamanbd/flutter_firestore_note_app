import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

// ignore: must_be_immutable
class AddNoteScreen extends StatefulWidget {
  User user;
  // ignore: use_key_in_widget_constructors
  AddNoteScreen(this.user);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  // /ForCreatingProgressIndicator
  bool loading = false; 
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
              horizontal: size.width / 15,
              vertical: size.height / 30,
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
                SizedBox(
                  height: size.height / 60,
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 4,
                ),
                SizedBox(
                  height: size.height / 20,
                ),
                const Text(
                  'Description',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height / 60,
                ),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  minLines: 5,
                  maxLines: 10,
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: size.width,
                        height: size.height / 10,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (titleController.text == "" ||
                                  descController.text == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('All fields are required',textAlign: TextAlign.center,)));
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                await FirestoreService().insertNote(
                                  titleController.text,
                                  descController.text,
                                  widget.user.uid,
                                );
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Add Note',
                              style: TextStyle(fontSize: 19),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.pink,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
