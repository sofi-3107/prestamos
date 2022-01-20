import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/repositories/crud_repository.dart';

class UsuariosService implements CrudRepository<Usuario> {
  final rootPath = 'http://192.168.100.4:3000/';
  @override
  Future<String> createNew(Usuario object, String pathSection) async {
    final response = await http.put(Uri.parse(rootPath + pathSection),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: object.toJson());
    return response.toString();
  }

  @override
  Future<List<Usuario>> getAll(String pathSection) async {
    final response = await http.get(Uri.parse(rootPath + pathSection));
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

  @override
  Future<Usuario> getOne(int id, String pathSection) {
    // TODO: implement getOne
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Usuario object, String pathSection) {
    // TODO: implement update
    throw UnimplementedError();
  }

  /**No funciona sin los headers, da error de que no rconoce el caracter */
  @override
  Future<String> delete(int id, String pathSection) async {
    final response = await http.delete(
      Uri.parse(rootPath + pathSection + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return await json.decode(response.body.toString());
  }

  /*  static Future<List<Usuario>> getAllUsuarios() async {
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
  } */
}
