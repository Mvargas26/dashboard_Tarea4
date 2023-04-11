import 'dart:convert';

String usuarioModelToJson(List<Usuario_Model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario_Model {
  late int identificacion;
  late String nombre;
  late String apellidos;
  late String contrasena;
  late bool estado;
  late String idAdmiRegistra;

  Usuario_Model(this.identificacion, this.nombre, this.apellidos,
      this.contrasena, this.estado, this.idAdmiRegistra);

  Map<String, dynamic> toJson() => {
        "identificacion": identificacion,
        "nombre": nombre,
        "apellidos": apellidos,
        "contrasena": contrasena,
        "estado": estado,
        "idAdmiRegistra": idAdmiRegistra,
      };
}
