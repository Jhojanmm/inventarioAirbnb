import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NovedadForm extends StatefulWidget {
  final List<dynamic> inventario;
  final String id;

  const NovedadForm({Key? key, required this.inventario, required this.id})
      : super(key: key);

  @override
  _NovedadFormState createState() => _NovedadFormState();
}

class _NovedadFormState extends State<NovedadForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _camasController = TextEditingController();
  final TextEditingController _lavadorasController = TextEditingController();
  final TextEditingController _cortinasController = TextEditingController();
  final TextEditingController _toallasController = TextEditingController();
  final TextEditingController _mueblesController = TextEditingController();
  final TextEditingController _cobijasController = TextEditingController();
  final TextEditingController _almohadasController = TextEditingController();
  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un texto';
    }
    return null;
  }

  void _enviarNovedad() {
    if (_formKey.currentState!.validate()) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final DateTime now = DateTime.now();
      _firestore.collection('novedades').add({
        'texto': _textFieldController.text,
        'camas': _camasController.text,
        'lavadoras': _lavadorasController.text,
        'cortinas': _cortinasController.text,
        'toallas': _toallasController.text,
        'muebles': _mueblesController.text,
        'cobijas': _cobijasController.text,
        'almohadas': _almohadasController.text,
        'id': widget.id,
        'fecha': now.toString(),
      }).then((value) {
        final String novedadId = value.id;
        final CollectionReference alojamientoRef =
            _firestore.collection('inventario');
        alojamientoRef
            .where('id', isEqualTo: widget.id)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            alojamientoRef.doc(doc.id).update({
              'camas': _camasController.text,
              'lavadoras': _lavadorasController.text,
              'cortinas': _cortinasController.text,
              'toallas': _toallasController.text,
              'muebles': _mueblesController.text,
              'cobijas': _cobijasController.text,
              'almohadas': _almohadasController.text,
            });
          });
        });
      });

      

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Novedad enviada'),
            content: Text('La novedad se ha enviado correctamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // Agregar SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Agregar Novedad',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Text(
                      'Texto',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Escribe aquí',
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    validator: _validateText,
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Text(
                      'Detalles del Apartamento',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Camas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _camasController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText:
                                      widget.inventario[0]["camas"].toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lavadoras',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _lavadorasController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.inventario[0]["lavadoras"]
                                      .toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Almohadas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _almohadasController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.inventario[0]["almohadas"]
                                      .toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cortinas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _cortinasController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.inventario[0]["cortinas"]
                                      .toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Toallas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _toallasController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.inventario[0]["toallas"]
                                      .toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Muebles',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _mueblesController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.inventario[0]["muebles"]
                                      .toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cobijas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextFormField(
                                controller: _cobijasController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: widget.inventario[0]["cobijas"]
                                      .toString(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  
                  SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey, // Color de fondo del botón
                    ),
                    onPressed: _enviarNovedad,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Enviar Novedad',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
