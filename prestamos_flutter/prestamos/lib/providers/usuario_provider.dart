import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prestamos/services/usuarios_service.dart';
import 'package:prestamos/models/usuario.dart';

class UsuarioProvider extends ChangeNotifier {
  List<Usuario> _usuarios = [];

  UsuariosService service = UsuariosService();
  Future<List<Usuario>> getUsuarios() => service.getAll();

  addUsuario(Usuario user) async {
    // _usuarios.add(user);

    var resp = await service.createNew(user);
    notifyListeners();
    return resp;
  }

  dropUsuario(Usuario user) async {
    /*_usuarios.removeWhere((u) => u.id == user.id);*/
    var resp = await service.delete(user.id!);
    notifyListeners();
    return resp;
  }

  replaceUsuario(Usuario user) async {
/*     _usuarios.where((u) => u.id == user.id).map((e) {
      e.nombre = user.nombre;
      e.apellido = user.apellido;
      e.telefono = user.telefono;
      e.curso = user.curso;
      e.dni = user.dni;
      e.observaciones = user.observaciones;
    }); */
    var resp = await service.update(user);
    notifyListeners();
    return resp;
  }
}
