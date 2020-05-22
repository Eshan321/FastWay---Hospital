import 'dart:async';
import 'package:Hospital_FastWay/Hospitals/Kalubovila.dart';
import 'package:Hospital_FastWay/HospitalsScreen/KalubovilaScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class HomeKalubovila extends StatefulWidget {
  @override
  _HomeKalubovilaState createState() => new _HomeKalubovilaState();
}

final kalubovilasReference = FirebaseDatabase.instance.reference().child('kalubovila');

class _HomeKalubovilaState extends State<HomeKalubovila> {
  List<Kalubovila> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();

    _onNoteAddedSubscription = kalubovilasReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription = kalubovilasReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fast Way Database',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fast Way Database'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${items[position].title}',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      subtitle: Text(
                        '${items[position].description}',
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[850]
                        ),
                      ),
                      leading: Column(
                        children: <Widget>[
                          IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteKalubovila(context, items[position], position)),
                        ],
                      ),
                      onTap: () => _navigateToKalubovila(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createKalubovila(context),
        ),
      ),
    );
  }

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Kalubovila.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue = items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] = new Kalubovila.fromSnapshot(event.snapshot);
    });
  }

  void _deleteKalubovila(BuildContext context, Kalubovila note, int position) async {
    await kalubovilasReference.child(note.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToKalubovila(BuildContext context, Kalubovila note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KalubovilaScreen(note)),
    );
  }

  void _createKalubovila(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KalubovilaScreen(Kalubovila(null, '', ''))),
    );
  }
}
