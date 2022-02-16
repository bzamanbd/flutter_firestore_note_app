import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';
import '../screens/edit_note_screen.dart';
import '../screens/addnote_screen.dart';
import '../screens/login_screen.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';


// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  ///to catch the user's uid///
  User user;
  HomeScreen(this.user, {Key? key}) : super(key: key);
 /// to create progress indicator///
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    /// for responsive height and width value///
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Note App'),
          centerTitle: true,
          backgroundColor: Colors.pink,
          actions: [
            loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : TextButton.icon(
                    onPressed: () async {
                      ///for signout///
                      await AuthService().exit();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          (route) => false);
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: TextButton.styleFrom(primary: Colors.white)),
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notes')
              .where('userid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length > 0) {
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    ///Json model will be converted into NoteModel///
                    NoteModel note =
                        NoteModel.fromJson(snapshot.data.docs[index]);
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        size.width/30,
                        size.height/50,
                        size.width/30,
                        0),
                      child: Card(
                        color: Colors.teal,
                        elevation: 5,
                        child: ListTile(
                          title: Text(note.title),
                          subtitle: Text(note.description),
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>EditNoteScreen(note: note))),
                          onLongPress: (){
                            ///to open the dialog popup screen///
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    alignment: Alignment.center,
                                    title: const Text('Please Confirm'),
                                    content:
                                        const Text('Are you sure to delete?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            ///to delete note by id///
                                            await FirestoreService()
                                                .deleteNote(note.id);
                                            ///to close the dialog popup screen//
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes')),
                                      TextButton(
                                          onPressed: () {
                                            ///to close the dialog popup screen//
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No')),
                                    ],
                                    elevation: 5,
                                  );
                                });
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('no data found'));
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (_) => AddNoteScreen(user)));
                },
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
