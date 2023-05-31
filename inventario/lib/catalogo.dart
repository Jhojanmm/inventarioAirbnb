import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventario/alojamiento.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de alojamientos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Catálogo de alojamientos'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference alojamientoCollection =
      FirebaseFirestore.instance.collection('alojamiento');
  final CollectionReference inventarioCollection =
      FirebaseFirestore.instance.collection('inventario');
  List housesInfo = [];

  @override
  void initState() {
    super.initState();
    getInventario();
  }

  void getInventario() async {
    QuerySnapshot houses = await inventarioCollection.get();
    if (houses.docs.length != 0) {
      for (var doc in houses.docs) {
        housesInfo.add(doc.data());
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, // Ocultar el banner de depuración
      home: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // implementar la búsqueda
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: alojamientoCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ocurrió un error al cargar los datos'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;
          final alojamientos =
              data.docs.map((doc) => Alojamiento.fromSnapshot(doc)).toList();

          return ListView.builder(
            itemCount: alojamientos.length,
            itemBuilder: (context, index) {
              final alojamiento = alojamientos[index];
              final inventario = housesInfo
                  .where((element) => element["id"] == alojamiento.id)
                  .toList();

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlojamientoPage(
                        inventario: inventario,
                        alojamiento: alojamiento,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                          size: 48,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alojamiento.direccion,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              inventario.isEmpty
                                  ? Text(
                                      "No hay información",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    )
                                  : Text(
                                      "Cantidad de habitaciones: ${inventario[0]["habitaciones"]}",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    ));
  }
}
