import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prestamos/models/usuario.dart';

class UsuariosService {
  static Future<List<Usuario>> getAllUsuarios() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.4:3000/usuarios'));
    if (response.statusCode == 200) {
      final decodedResponse = await json.decode(response.body);
      List<Usuario> usuarios = [];
      for (var i = 0; i < decodedResponse.length; i++) {
        usuarios.add(Usuario.fromJson(decodedResponse[i]));
      }

      return usuarios;
    }
    throw Exception('Failed to load users');
  }
}
