import 'dart:convert';
import 'package:dashboard_api_2/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class Usuario_Service {
  //VARIABLES
  static String _baseURL = 'http://10.0.2.2:5182/';

  //*** Metodo para obtener Usuarios
  static Future<List<Usuario_Model>?> getUsuarios() async {
    var url = Uri.parse(_baseURL + "Usuario");
    final response = await http.get(url);
    List<Usuario_Model> Usuarios = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);

      for (var item in jsonData) {
        Usuarios.add(Usuario_Model(
            item["identificacion"],
            item["nombre"],
            item["apellidos"],
            item["contrasena"],
            item["estado"],
            item["idAdmiRegistra"]));
      }
      return Usuarios;
    } else {
      throw Exception("Fallo");
    }
  } //fn getUsuarios

  //*** Metodo para crear Usuario
  static Future<bool> createUsuario(Usuario_Model c) async {
    var url = Uri.parse(_baseURL + 'Usuario');

    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(c.toJson()));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } //fn createUsuario

  //*** Metodo para EDITAR Usuario
  static Future<bool> editUsuario(Usuario_Model c) async {
    var url = Uri.parse(_baseURL + 'Usuario');

    final response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(c.toJson()));

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } //fn createUsuario

  //*** Metodo para eliminar Usuario
  static Future<String> deleteUsuario(int identificacion) async {
    var url = Uri.parse(_baseURL + 'Usuario/' + identificacion.toString());

    final response = await http.put(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 201 || response.statusCode == 200) {
      return "Eliminado";
    } else {
      return response.statusCode.toString();
    }
  } //fn createUsuario
}//fin class