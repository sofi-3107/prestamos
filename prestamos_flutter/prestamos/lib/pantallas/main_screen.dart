import 'package:flutter/material.dart';
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

  var listaPrueba = [
    'sandía',
    'Manzana',
    'Pera',
    'Uva',
    'Banana',
    'Frutilla',
    'Ciruela',
    'Manzana',
    'Pera',
    'Uva',
    'Banana',
    'Frutilla',
    'Ciruela',
    'Manzana',
    'Pera',
    'Uva',
    'Banana',
    'Frutilla',
    'Ciruela',
  ];

  List<Usuario> traidos = [];

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsuarioProvider>(context);
    users.getUsuarios().then(((List<Usuario> usuarios) {
      print(usuarios[0].nombre);
      widget.traidos.addAll(usuarios);
      print('traidos: ' + widget.traidos[0].apellido.toString());
    }));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuarios'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return ItemUsuario(indice: index, lista: widget.traidos);
            }, childCount: widget.traidos.length))
          ],
        ));
  }
}

class ItemUsuario extends StatelessWidget {
  const ItemUsuario({Key? key, @required this.indice, @required this.lista})
      : super(key: key);

  final indice;
  final lista;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      child: ListTile(
          title: Row(children: [
        Text(lista[indice].nombre),
        Text(lista[indice].apellido)
      ])),
    );
  }
}
