// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  int? id;
  String? nombre;
  String? apellido;
  String? curso;
  String? dni;
  String? telefono;
  dynamic observaciones;

  Usuario({
    this.id,
    this.nombre,
    this.apellido,
    this.curso,
    this.dni,
    this.telefono,
    this.observaciones,
  });

  //JsonDecode devuelve un Map<String,dynamic>
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        curso: json["curso"],
        dni: json["dni"],
        telefono: json["telefono"],
        observaciones: json["observaciones"],
      );

// Para crear un Json hay que convertir el objeto Usuario en un Map<String,dynamic>
  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "curso": curso,
        "dni": dni,
        "telefono": telefono,
        "observaciones": observaciones,
      };

  //static String usuarioToJson(Usuario data) => json.encode(data.toJson());
}
