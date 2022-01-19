import 'package:flutter/material.dart';
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/pantallas/user_form.dart';
import 'package:prestamos/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

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
    /*users.getUsuarios().then(((List<Usuario> usuarios) {
      print(usuarios[0].nombre);
      widget.traidos.addAll(usuarios);
      print('traidos: ' + widget.traidos[0].apellido.toString());
    }));*/

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
        centerTitle: true,
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
                  }, childCount: widget.traidos.length)),
                ],
              );
            } else if (snaphot.hasError) {
              return const Text('Ha ocurrido un error');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserForm()));
          },
          child: Icon(Icons.add)),
    );
  }

// este future es una promesa que debe tener el mismo tipo que el future dentro del widget futurebuilder
  Future<List<Usuario>> _populateTraidos(users, traidos) async {
    await users.getUsuarios().then(((List<Usuario> usuarios) {
      traidos.addAll(usuarios);
      print(traidos.length);
    }));
    if (traidos == null) {
      return [];
    } else {
      return traidos;
    }
  }
}

class ItemUsuario extends StatefulWidget {
  ItemUsuario({Key? key, @required this.indice, @required this.lista})
      : super(key: key);

  final indice;
  final lista;

  @override
  State<ItemUsuario> createState() => _ItemUsuarioState();
}

class _ItemUsuarioState extends State<ItemUsuario> {
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(1),
      child: Dismissible(
        key: Key(widget.indice.toString()),
        onDismissed: (direction) {},
        background: Container(
            color: Colors.red,
            child: const Center(
                child: Text("Estas por eliminar este usuario",
                    style: TextStyle(fontSize: 15, color: Colors.white)))),
        child: ListTile(
            title: Row(children: [
              Text(widget.lista[widget.indice].nombre),
              Container(
                width: 50,
              ),
              Text(widget.lista[widget.indice].apellido),
            ]),
            onLongPress: () {}),
      ),
    );
  }
}



/* PARA HACER PRUEBAS*/
/**Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blueAccent,
                  content:
                      Text('Aqui se navegaria a la pantalla del formulario')));
              Fluttertoast.showToast(
                  msg: 'vas a navegar al formulario',
                  backgroundColor: Colors.pink,
                  textColor: Colors.blue,
                  gravity: ToastGravity.TOP); */
