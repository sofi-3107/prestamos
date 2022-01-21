import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key, this.usuario}) : super(key: key);

  final Usuario? usuario;

  /**Lógica a implementar, si el objeto usuario llega vacío es un formulario de alta y se usan las variables definidas abajo, si no se 
   * se cargan los datos que trae el objeto para ser editados
  */
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _commonValidations = MultiValidator([
    RequiredValidator(errorText: "Debe Completar este campo"),
  ]);

  @override
  void initState() {
    super.initState();
  }

  String _nombre = "";
  String _apellido = "";
  String _telefono = "";
  String _dni = "";
  String _curso = "";
  String _observaciones = "";

  Usuario emptyUser = Usuario(
      nombre: '',
      apellido: '',
      telefono: '',
      dni: '',
      curso: '',
      observaciones: '');

  @override
  Widget build(BuildContext context) {
    _stylizeInput(String label) =>
        InputDecoration(label: Text(label), border: OutlineInputBorder());
    return Scaffold(
      appBar: AppBar(title: Text('Crear Usuario'), centerTitle: true),
      body: SingleChildScrollView(
        key: Key('algo1000'),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      initialValue: widget.usuario?.apellido,
                      validator: _commonValidations,
                      decoration: _stylizeInput('Apellido'),
                      onSaved: (value) {
                        _apellido = value ?? 'NO tengo datos';
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      initialValue: widget.usuario?.nombre,
                      validator: _commonValidations,
                      decoration: _stylizeInput('Nombre'),
                      onSaved: (value) => _nombre = value!),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    initialValue: widget.usuario?.telefono,
                    onSaved: (value) => _telefono = value!,
                    validator: _commonValidations,
                    decoration: _stylizeInput('telefono'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      onSaved: (value) => _curso = value!,
                      initialValue: widget.usuario?.curso,
                      validator: _commonValidations,
                      decoration: _stylizeInput('curso')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      initialValue: widget.usuario?.observaciones,
                      onSaved: (value) => _observaciones = value!,
                      maxLength: 300,
                      maxLines: 5,
                      decoration: _stylizeInput('Observaciones')),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save_rounded),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (widget.usuario != null) {
                Provider.of<UsuarioProvider>(context, listen: false)
                    .replaceUsuario(widget.usuario!)
                    .then((msg) => print(msg));
              } else {
                if (_apellido != null || _nombre != null || _telefono != null) {
                  Provider.of<UsuarioProvider>(context, listen: false)
                      .addUsuario(Usuario(
                          dni: _dni,
                          nombre: _nombre,
                          apellido: _apellido,
                          telefono: _telefono,
                          curso: _curso))
                      .then((resp) => Fluttertoast.showToast(msg: resp));

                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Debe completar los campos obligatorios');
                }
              }
            }
          }),
    );
  }
}
