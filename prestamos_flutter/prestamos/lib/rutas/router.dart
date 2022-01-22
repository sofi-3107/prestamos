import 'package:flutter/material.dart';
import 'package:prestamos/models/usuario.dart';
import 'package:prestamos/pantallas/detail_screen.dart';
import 'package:prestamos/pantallas/main_screen.dart';
import 'package:prestamos/pantallas/user_form.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings
        .arguments; // De este modo se extraen los argumentos dsde una ruta de

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => FirstScreen());
      case '/detail':
        return MaterialPageRoute(builder: (context) => Detail(user: args));
      case '/editUser':
        if (args is Usuario) {
          return MaterialPageRoute(
              builder: (context) => UserForm(usuario: args));
        } else {
          return _errorRoute();
        }
      default:
        return _errorRoute();
    }
  }

  /**Desde el widget que usa la ruta se pone Navigatio.of(context).pushNamed('/ruta',arguments:Usuario) */

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Esta ruta no existe')),
            body: Center(
                child: Text(
                    'Has accedido a una ubicación erronea o inexistente'))));
  }
}
