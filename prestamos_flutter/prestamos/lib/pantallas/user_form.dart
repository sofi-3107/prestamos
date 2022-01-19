import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _stylizeInput(String label) =>
        InputDecoration(label: Text(label), border: OutlineInputBorder());
    return Scaffold(
      appBar: AppBar(title: Text('Editar Usuario'), centerTitle: true),
      body: SingleChildScrollView(
        key: Key('algo1000'),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(decoration: _stylizeInput('Apellido')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(decoration: _stylizeInput('Nombre')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(decoration: _stylizeInput('telefono')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(decoration: _stylizeInput('curso')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      maxLength: 300,
                      maxLines: 5,
                      decoration: _stylizeInput('Observaciones')),
                ],
              )),
        ),
      ),
    );
  }
}
