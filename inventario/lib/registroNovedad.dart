import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventario/alojamiento.dart';



class Registro extends StatefulWidget {
  const Registro({Key? key, required this.title, required this.id}) : super(key: key);

  final String title;
  final String id;

  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final CollectionReference alojamientoCollection =
      FirebaseFirestore.instance.collection('alojamiento');
  final CollectionReference inventarioCollection =
      FirebaseFirestore.instance.collection('novedades');
  List housesInfo = [];

  @override
  void initState() {
    super.initState();
    getInventario();
  }

  void getInventario() async {
    QuerySnapshot houses = await inventarioCollection.get();
    if (houses.docs.length != 0) {
      int i = 0;
      int j = 0;
      List novedades = [];
      for (var doc in houses.docs) {
        novedades.add(doc.data());
      }
      for (var doc in houses.docs) {
        if (novedades[j]["id"] == widget.id) {
          housesInfo.add(doc.data());
        }
        j = j + 1;
      }
      print(novedades);
      novedades = [];
      j = 0;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de novedades',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: housesInfo.length,
              itemBuilder: (BuildContext context, int index) {
                final novedad = housesInfo[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400]!,
                        blurRadius: 2,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        novedad['texto']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        novedad['texto']!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
