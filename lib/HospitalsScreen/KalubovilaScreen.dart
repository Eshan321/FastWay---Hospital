import 'package:Hospital_FastWay/Hospitals/Kalubovila.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class KalubovilaScreen extends StatefulWidget {
  final Kalubovila kalubovila;
  KalubovilaScreen(this.kalubovila);

  @override
  State<StatefulWidget> createState() => new _KalubovilaScreenState();
}

final kalubovilasReference = FirebaseDatabase.instance.reference().child('kalubovila');

class _KalubovilaScreenState extends State<KalubovilaScreen> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.kalubovila.title);
    _descriptionController = new TextEditingController(text: widget.kalubovila.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Align(alignment: Alignment.center, child:Text("Admit Pation    ",style: TextStyle(fontSize: 26.0))),
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(alignment: Alignment.centerLeft, child:Text("Name",style: TextStyle(fontSize: 20.0))),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Pation Name'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            Align(alignment: Alignment.centerLeft, child:Text("Bed",style: TextStyle(fontSize: 20.0))),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Pation Bed Number'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              color: Colors.blue,
              child: (widget.kalubovila.id != null) ? Text('Update',style: TextStyle(fontSize: 20.0, color: Colors.white))
                : Text('Add',style: TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: () {
                if (widget.kalubovila.id != null) {
                  kalubovilasReference.child(widget.kalubovila.id).set({
                    'title': _titleController.text,
                    'description': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  kalubovilasReference.push().set({
                    'title': _titleController.text,
                    'description': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
