import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';

import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/providers/usuario_provider.dart';

import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key, this.usuario}) : super(key: key);

  final dynamic usuario;

  /**Lógica a implementar, si el objeto usuario llega vacío es un formulario de alta 
   * y se usan las variables definidas abajo, si no se 
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
                      decoration: _stylizeInput(
                          'Apellido'), // Para reutilizar el widget necesito recibir un array con los nombres de los atributos de clase que sran los nombres de los campos
                      onSaved: (value) {
                        emptyUser.apellido = value ?? 'No tengo datos';
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      initialValue: widget.usuario?.nombre,
                      validator: _commonValidations,
                      decoration: _stylizeInput('Nombre'),
                      onSaved: (value) => emptyUser.nombre = value!),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    initialValue: widget.usuario?.telefono,
                    onSaved: (value) => emptyUser.telefono = value!,
                    validator: _commonValidations,
                    decoration: _stylizeInput('telefono'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      onSaved: (value) => emptyUser.curso = value!,
                      initialValue: widget.usuario?.curso,
                      validator: _commonValidations,
                      decoration: _stylizeInput('curso')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      initialValue: widget.usuario?.observaciones,
                      onSaved: (value) => emptyUser.observaciones = value!,
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
                widget.usuario!.nombre = emptyUser.nombre;
                widget.usuario!.apellido = emptyUser.apellido;
                widget.usuario!.telefono = emptyUser.telefono;
                widget.usuario!.curso = emptyUser.curso;
                widget.usuario!.observaciones = emptyUser.observaciones;
                Provider.of<UsuarioProvider>(context, listen: false)
                    .replaceUsuario(widget.usuario!);
                // Fluttertoast.showToast(msg: 'Usuario modificado');
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Usuario modificado correctamente'),
                    backgroundColor: Colors.blue));
                Navigator.pop(context);
              } else {
                if (emptyUser.apellido != null ||
                    emptyUser.nombre != null ||
                    emptyUser.telefono != null) {
                  Provider.of<UsuarioProvider>(context, listen: false)
                      .addUsuario(emptyUser);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Usuario creado correctamente'),
                      backgroundColor: Colors.blue));
                  Navigator.pop(context);
                } else {
                  /*Fluttertoast.showToast(
                      msg: 'Debe completar los campos obligatorios');*/

                }
              }
            }
          }),
    );
  }
}
