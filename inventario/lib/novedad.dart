import 'dart:html';

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

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un texto';
    }
    return null;
  }

  void _enviarNovedad() {
    if (_formKey.currentState!.validate()) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
       _firestore.collection('novedades').add({
         'texto': _textFieldController.text,
         'camas': _camasController.text,
         'lavadoras': _lavadorasController.text,
         'cortinas': _cortinasController.text,
         'id' : widget.id,
       });

      // Reiniciar los controladores de texto después de enviar la novedad
      _textFieldController.clear();
      _camasController.clear();
      _lavadorasController.clear();
      _cortinasController.clear();

      // Mostrar un diálogo de éxito
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
        body: Padding(
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
                              "camas",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextFormField(
                              controller: _camasController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: widget.inventario[0]["camas"].toString()
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
                                labelText: widget.inventario[0]["lavadoras"].toString(),
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
                                labelText: widget.inventario[0]["cortinas"].toString(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  
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
    );
  }
}
