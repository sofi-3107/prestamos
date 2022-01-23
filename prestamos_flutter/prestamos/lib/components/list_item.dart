import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  Item(
      {Key? key,
      @required this.indice,
      @required this.lista,
      @required this.provider})
      : super(key: key);
  final indice;
  final lista;
  final provider;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(widget.lista[widget.indice].toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          widget.provider.dropUsuario(widget.lista[widget.indice]);
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
              onTap: () => Navigator.of(context)
                  .pushNamed('/detail', arguments: widget.lista[widget.indice]),
              onLongPress: () {
                Navigator.of(context).pushNamed('/editUser',
                    arguments: widget.lista[widget.indice]);
              }),
        ));
  }
}
