import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prestamos/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getAllUsuarios() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/usuarios'));
    if (response.statusCode == 200) {
      final decodedResponse = await json.decode(response.body);
      List<Usuario> usuarios = [];
      for (var user in decodedResponse['usuario']) {
        usuarios.add(Usuario.fromJson(user));
      }
      return usuarios;
    }
    throw Exception('Failed to load users');
  }
}
