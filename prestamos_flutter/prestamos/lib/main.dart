import 'package:flutter/material.dart';
import 'package:prestamos/pantallas/main_screen.dart';
import 'package:prestamos/providers/usuario_provider.dart';
import 'package:prestamos/rutas/router.dart';
import 'package:provider/provider.dart';

import 'models/usuario.dart';

void main() {
  runApp(const ProviderContainer());
}

class ProviderContainer extends StatelessWidget {
  const ProviderContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UsuarioProvider(),
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
