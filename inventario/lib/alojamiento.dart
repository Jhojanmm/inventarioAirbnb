import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventario/novedad.dart';
import 'package:inventario/registroNovedad.dart';

class Alojamiento {
  final String id;
  final String direccion;

  Alojamiento({required this.id, required this.direccion});

  factory Alojamiento.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Alojamiento(
      id: data['id'],
      direccion: data['direccion'],
    );
  }
}

class AlojamientoPage extends StatelessWidget {
  final List<dynamic> inventario;
  final Alojamiento alojamiento;

  const AlojamientoPage({
    Key? key,
    required this.inventario,
    required this.alojamiento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, // Ocultar el banner de depuración
      home: Scaffold(
      appBar: AppBar(
        title: Text(
          alojamiento.direccion,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Inventario',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: inventario.length,
                itemBuilder: (context, index) {
                  final element = inventario[index];
                  if (element['id'] == alojamiento.id) {
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Detalle de inventario',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInventoryItem(
                                context,
                                'Camas',
                                element['camas'].toString(),
                              ),
                              _buildInventoryItem(
                                context,
                                'Lavadoras',
                                element['lavadoras'].toString(),
                              ),
                              _buildInventoryItem(
                                context,
                                'Cortinas',
                                element['cortinas'].toString(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Text("No hay información"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NovedadForm(
                    inventario: inventario,
                    id: alojamiento.id,
                  ),
                ),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blueGrey[800],
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Registro(
                    title: "Registro de novedades",
                    id: alojamiento.id,
                  ),
                ),
              );
            },
            child: Icon(Icons.history),
            backgroundColor: Colors.blueGrey[800],
          ),
        ],
      ),
    ));
  }

  Widget _buildInventoryItem(
    BuildContext context,
    String title,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
