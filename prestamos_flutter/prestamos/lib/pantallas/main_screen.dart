import 'package:flutter/material.dart';
import 'package:prestamos/components/list_item.dart';
import 'package:prestamos/models/usuario.dart';
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
    var noListenProvider = Provider.of<UsuarioProvider>(context, listen: false);
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
              users.getUsuarios().then((data) => traidos = data);

              return CustomScrollView(
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Item(
                        indice: index,
                        lista: traidos,
                        provider: noListenProvider);
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
