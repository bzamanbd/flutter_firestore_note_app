import 'package:flutter/material.dart';
import 'package:flutter_firestore_note_app/models/note_model.dart';
import 'package:flutter_firestore_note_app/services/firestore_service.dart';

// ignore: must_be_immutable
class EditNoteScreen extends StatefulWidget {
  NoteModel note;
  EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool loading = false;
  @override
  void initState() {
    titleController.text = widget.note.title;
    descController.text = widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          alignment: Alignment.center,
                          title: const Text('Please Confirm'),
                          content: const Text('Are you sure to delete?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await FirestoreService()
                                      .deleteNote(widget.note.id);
                                  //to close the dialog//
                                  Navigator.pop(context);
                                  //to close the edite screen//
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                          elevation: 5,
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          ],
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
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        width: size.width,
                        height: size.height / 10,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (titleController.text == '' ||
                                  descController.text == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('All fields are required')));
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                await FirestoreService().updateNote(
                                    widget.note.id,
                                    titleController.text,
                                    descController.text);
                                setState(() {
                                  loading = false;
                                });
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'Update Note',
                              style: TextStyle(fontSize: 19),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.teal,
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
