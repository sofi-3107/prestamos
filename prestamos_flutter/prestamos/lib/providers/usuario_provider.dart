import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:prestamos/services/usuarios_service.dart';
import 'package:prestamos/models/usuario.dart';

class UsuarioProvider extends ChangeNotifier {
  List<Usuario> _usuarios = [];

  UsuariosService service = UsuariosService();
  Future<List<Usuario>> getUsuarios() => service.getAll('usuarios');

  void addUsuario(Usuario user) {
    _usuarios.add(user);
    notifyListeners();
  }

  dropUsuario(Usuario user) async {
    /*_usuarios.removeWhere((u) => u.id == user.id);*/
    var resp = await service.delete(user.id!, 'usuarios/delete/');
    notifyListeners();
    return resp;
  }

  void replaceUsuario(Usuario user) {
    _usuarios.where((u) => u.id == user.id).map((e) {
      e.nombre = user.nombre;
      e.apellido = user.apellido;
      e.telefono = user.telefono;
      e.curso = user.curso;
      e.dni = user.dni;
      e.observaciones = user.observaciones;
    });
    notifyListeners();
  }
}
