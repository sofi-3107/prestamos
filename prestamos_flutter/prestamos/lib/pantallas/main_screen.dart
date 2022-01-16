import 'package:flutter/material.dart';
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/services/usuarios_service.dart';

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

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Frutas'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return ItemFrutas(index: index, lista: widget.listaPrueba);
            }, childCount: widget.listaPrueba.length))
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
      child: ListTile(title: Text(lista[index])),
    );
  }
}
