import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CatalogPage());
}

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  List housesInfo = [];

  @override
  void initState() {
    super.initState();
    getHouses();
  }

  void getHouses() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("alojamiento");

    QuerySnapshot houses = await collectionReference.get();

    if (houses.docs.length != 0) {
      for (var doc in houses.docs) {
        housesInfo.add(doc.data());
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catálogo de casas'),
      ),
      body: ListView.builder(
        itemCount: housesInfo.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(housesInfo[index]['direccion']),
              subtitle: Text('ID: ${housesInfo[index]['id']}'),
            ),
          );
        },
      ),
    );
  }
}
