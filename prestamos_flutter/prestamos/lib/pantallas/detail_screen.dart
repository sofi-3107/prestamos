import 'package:flutter/material.dart';
import 'package:prestamos/models/usuario.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key, @required this.user}) : super(key: key);

  final user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(user.nombre), centerTitle: true),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(user.nombre),
              SizedBox(height: 20),
              Text(user.apellido),
              SizedBox(height: 20),
              Text(user.telefono),
              SizedBox(height: 20),
              Text(user.curso),
            ],
          ),
        ));
  }
}
