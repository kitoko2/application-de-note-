import "package:flutter/material.dart";
import "dart:math";

import 'package:flutter_app12/notesDatabase.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(30, 80, 200, 1),
      ),
      debugShowCheckedModeBanner: false,
      title: "notes",
      home: MyHomme(),
    );
  }
}

class MyHomme extends StatefulWidget {
  @override
  _MyHommeState createState() => _MyHommeState();
}

List colora = [
  Color.fromRGBO(100, 12, 5, 0.4),
  Color.fromRGBO(10, 120, 5, 0.4),
];
List colorb = [
  Colors.red,
  Colors.green,
  Colors.blue,
];

class _MyHommeState extends State<MyHomme> {
  var gv = 1;
  List<Radio> f() {
    List<Widget> l = [];
    for (var i = 0; i < 2; i++) {
      Row row = Row(
        children: [
          Radio(
              value: i,
              groupValue: gv,
              onChanged: (e) {
                setState(() {
                  gv = e;
                });
              })
        ],
      );
      l.add(row);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 80, 200, 1),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(30, 80, 200, 1),
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'Activités',
                  style: TextStyle(fontSize: 29, color: Colors.white),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: Container(
              padding: EdgeInsets.only(
                right: 25,
                left: 25,
                top: 35,
                bottom: 20,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: FutureBuilder<List<MiniCont>>(
                future: NotesDataBase.instance.notes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List mesNotes = snapshot.data;
                    return Scrollbar(
                      //juste pour la scrollbar
                      child: GridView.builder(
                        itemCount: mesNotes.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 20,
                        ),
                        itemBuilder: (BuildContext context, i) {
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: mesNotes[i].isFa == 1
                                      ? colora[mesNotes[i].isFa]
                                      : colora[0],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: mesNotes[i].isFa == 1
                                            ? colorb[mesNotes[i].isFa]
                                            : colorb[0],
                                        //si c'est favoris(1)colorb[1]:colorb[0]
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(10),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          mesNotes[i].titre.toUpperCase(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                            "${mesNotes[i].j}/${mesNotes[i].m}/${mesNotes[i].y}",
                                            style: TextStyle(fontSize: 10)),
                                        Text(
                                          "${mesNotes[i].heure}h ${mesNotes[i].minute}",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Flexible(
                                      flex: 2,
                                      child: SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Text(mesNotes[i].note),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 0,
                                      child: Text(
                                        mesNotes[i].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              mesNotes[i].isFa == 1
                                  ? Positioned(
                                      top: -1,
                                      right: -1,
                                      child: Container(
                                        child: Image.asset("asset/pin.png"),
                                        width: 20,
                                        height: 20,
                                      ),
                                    )
                                  : Container(),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          String titre;
          String note;
          String name;

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "titre de la note",
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (e) {
                      setState(() {
                        titre = e;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "entrer la note",
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (n) {
                      setState(() {
                        note = n;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "nom de l'auteur",
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (n) {
                      setState(() {
                        name = n;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: f(),
                  ),
                  Text("$gv"),
                  FloatingActionButton(
                    onPressed: () {
                      print("$gv");
                      print("$titre $note $name");
                      Navigator.pop(context);
                      setState(() {
                        if (titre != null && note != null && name != null) {
                          //pour un ajout dans la table note de la bd
                          NotesDataBase.instance.insertNote(
                            MiniCont(
                                titre,
                                note,
                                name,
                                datetoday().day,
                                datetoday().month,
                                datetoday().year,
                                datetoday().hour,
                                datetoday().minute,
                                0),
                          );
                          // mesNotes.add(
                          //  minicount(...)
                          // );
                        }
                      });
                    },
                    child: Icon(Icons.check_circle_outline_sharp),
                  ),
                  Center(child: Text("valider")),
                ],
              );
            },
          );
        },
      ),
    );
  }

  DateTime datetoday() {
    DateTime t = DateTime.now();

    print("${t.hour}:${t.minute}");
    print("${t.day}/${t.month}/${t.year}");
    return t;
  }
}

class MiniCont {
  String titre;
  String note;
  String name;
  // Color a;
  // Color b;
  int j;
  int m;
  int y;
  int heure;
  int minute;
  int isFa;
  MiniCont(String titre, String note, String name, int j, int m, int y,
      int heure, int minute, int isFa) {
    this.titre = titre;
    this.note = note;
    this.name = name;
    // this.a = a;
    // this.b = b;
    this.heure = heure;
    this.minute = minute;
    this.j = j;
    this.m = m;
    this.y = y;
    this.isFa = isFa;
  }

  Map<String, dynamic> toMap() {
    return {
      "titre": titre,
      "note": note,
      "name": name,
      "jour": j,
      "mois": m,
      "annee": y,
      "heure": heure,
      "minute": minute,
      "isfa": isFa
    };
  }

  factory MiniCont.fromMap(Map<String, dynamic> map) {
    return MiniCont(
      map["titre"],
      map["note"],
      map["name"],
      map["jour"],
      map["mois"],
      map["annee"],
      map["heure"],
      map["minute"],
      map["isfa"],
    );
  }
}