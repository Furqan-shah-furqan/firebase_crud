import 'package:firebase_crud/Services/firebase_service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OpenBox extends StatelessWidget {
  OpenBox({super.key, this.docId, this.noteText});

  String? docId;
  final String? noteText;
  FirebaseService fS = FirebaseService();
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.text = noteText ?? '';
    return AlertDialog(  
      insetPadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(20),
      backgroundColor: const Color.fromARGB(255, 207, 179, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: const Color.fromARGB(255, 166, 115, 255),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.white, width: 2),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MaterialButton(
                color: const Color.fromARGB(255, 255, 140, 130),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              MaterialButton(
                color: Colors.greenAccent.shade200,
                onPressed: () {
                  if (docId == null) {
                    fS.addNewnote(controller.text);
                  } else {
                    fS.editNotes(docId!, controller.text);
                  }
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
