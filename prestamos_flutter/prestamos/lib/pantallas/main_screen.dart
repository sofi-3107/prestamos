import 'package:flutter/material.dart';
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/pantallas/detail_screen.dart';
import 'package:prestamos/pantallas/user_form.dart';
import 'package:prestamos/providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key? key}) : super(key: key);

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
    var users = Provider.of<UsuarioProvider>(context);
    List<Usuario> traidos = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Usuario>>(
          future: users.getUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              users.getUsuarios().then((data) {
                data.map((e) => print('dta pura: ${e.nombre} - ${e.apellido}'));
                traidos = data;
                traidos
                    .map((e) => print('traidos: ${e.nombre} - ${e.apellido}'));
              });

              return CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return ItemUsuario(indice: index, lista: traidos);
                  }, childCount: traidos.length)),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                  child: const Text('Ha ocurrido un error',
                      style: TextStyle(fontSize: 30, color: Colors.red)));
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
/*   Future<List<Usuario>> _obtenerListaUsuarios(
    users,
  ) async {
    traidos = await users.getUsuarios();
    return traidos;
  } */
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
    return Dismissible(
        key: Key(widget.lista[widget.indice].toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          Provider.of<UsuarioProvider>(context, listen: false)
              .dropUsuario(widget.lista[widget.indice]);
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Usuario eliminado')));
        },
        background: Container(
            color: Colors.red,
            child: const Align(
                alignment: Alignment(-0.8, 0.00),
                child: Icon(Icons.delete, color: Colors.white))),
        child: Card(
          child: ListTile(
              title: Row(children: [
                Text(widget.lista[widget.indice].nombre),
                Container(
                  width: 50,
                ),
                Text(widget.lista[widget.indice].apellido),
              ]),
              onTap:
                  () => /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Detail(
                            user: widget.lista[widget.indice],
                          ))) */
                      Navigator.of(context).pushNamed('/detail',
                          arguments: widget.lista[widget.indice]),
              onLongPress: () {
/*                 Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserForm(usuario: widget.lista[widget.indice])));
                           */
                Navigator.of(context).pushNamed('/editUser',
                    arguments: widget.lista[widget.indice]);
              }),
        ));
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
