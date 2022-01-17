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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<UsuarioProvider>(context);
    users.getUsuarios().then(((List<Usuario> usuarios) {
      print(usuarios[0].nombre);
      widget.traidos.addAll(usuarios);
      print('traidos: ' + widget.traidos[0].apellido.toString());
    }));

    var customScrollView = CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return ItemUsuario(indice: index, lista: widget.traidos);
        }, childCount: widget.traidos.length))
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuarios'),
        ),
        body: FutureBuilder<List<Usuario>>(
            future: _populateTraidos(users, widget.traidos),
            builder: (context, snaphot) {
              if (snaphot.hasData) {
                return CustomScrollView(
                  slivers: [
                    SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return ItemUsuario(indice: index, lista: widget.traidos);
                    }, childCount: widget.traidos.length))
                  ],
                );
              } else if (snaphot.hasError) {
                return const Text('Ha ocurrido un error');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }

  List<Usuario> _populateTraidos(users, traidos) {
    users.getUsuarios().then(((List<Usuario> usuarios) {
      traidos.addAll(usuarios);
    }));
    if (traidos == null) {
      return [];
    } else {
      return traidos;
    }
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
