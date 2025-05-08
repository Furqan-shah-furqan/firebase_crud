import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/Components/open_box.dart';
import 'package:firebase_crud/Services/firebase_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Home({super.key});

  FirebaseService fS = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 207, 179, 255),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return OpenBox();
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: fS.getNoteStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List notesList = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: notesList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = notesList[index];
                        String docId = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String noteText = data['name'];
                        return ListTile(
                          title: Text(noteText),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => OpenBox(
                                          docId: docId,
                                          noteText: noteText,
                                        ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  fS.deleteNotes(docId);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Text('No Notes');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
