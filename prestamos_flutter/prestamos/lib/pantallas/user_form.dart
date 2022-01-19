import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class UserForm extends StatefulWidget {
  UserForm({Key? key, @required this.isUpdate, this.id = 0}) : super(key: key);

  final isUpdate;
  final int id;
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _commonValidations = MultiValidator([
    RequiredValidator(errorText: "Debe Completar este campo"),
  ]);

  //final TextEditingController nombreController = TextEditingController();

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
                  TextFormField(
                      validator: _commonValidations,
                      decoration: _stylizeInput('Apellido')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      validator: _commonValidations,
                      decoration: _stylizeInput('Nombre')),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: _commonValidations,
                    decoration: _stylizeInput('telefono'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                      validator: _commonValidations,
                      decoration: _stylizeInput('curso')),
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save_rounded),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Fluttertoast.showToast(msg: 'Validacion hecha');
            }
          }),
    );
  }
}
