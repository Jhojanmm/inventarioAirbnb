import 'package:flutter/material.dart';

class AgregarNovedadForm extends StatefulWidget {
  const AgregarNovedadForm({Key? key}) : super(key: key);

  @override
  _AgregarNovedadFormState createState() => _AgregarNovedadFormState();
}

class _AgregarNovedadFormState extends State<AgregarNovedadForm> {
  final _formKey = GlobalKey<FormState>();

  String? _validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un texto';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(
        'Agregar Novedadd',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
      backgroundColor: Colors.blueGrey[800], // Se utiliza un color de fondo diferente para separar visualmente el AppBar del cuerpo del formulario
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Texto',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                validator: _validateText,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  // Agregué un texto descriptivo antes de cada TextFormField
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cantidad de Camas',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cantidad de Lavadoras',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cantidad de Cortinas',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //TODO: Enviar formulario
                  }
                },
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
    );
  }
}
