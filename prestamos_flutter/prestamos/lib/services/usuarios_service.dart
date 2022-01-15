import 'package:http/http.dart' as http;

class UsuariosService {
  dynamic getAllUsuarios() async {
    final response = await http.get('');
  }
}
