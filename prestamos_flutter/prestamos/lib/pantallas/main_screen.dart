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
    users
        .getUsuarios()
        .then(((List<Usuario> usuarios) => widget.traidos.addAll(usuarios)));

    widget.traidos.forEach((Usuario u) => print(u.nombre));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Frutas'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return ItemFrutas(index: index, lista: widget.traidos);
            }, childCount: widget.traidos.length))
          ],
        ));
  }
}

class ItemFrutas extends StatelessWidget {
  const ItemFrutas({Key? key, @required this.index, @required this.lista})
      : super(key: key);

  final index;
  final lista;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(1),
      child: ListTile(title: Text(lista[index].nombre)),
    );
  }
}
