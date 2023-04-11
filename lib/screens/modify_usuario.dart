import 'package:dashboard_api_2/models/usuario_model.dart';
import 'package:flutter/material.dart';

import '../Services/cliente_service.dart';

class ModifyUsuario extends StatefulWidget {
  //
  final Usuario_Model _usuario_model;
  ModifyUsuario(this._usuario_model);

  @override
  State<ModifyUsuario> createState() => _ModifyUsuarioState();
}

class _ModifyUsuarioState extends State<ModifyUsuario> {
  //VARIABLES
  bool _activo = false;
  late TextEditingController _idController;
  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _contrasenaController;
  late TextEditingController _admiRegistraController;
  bool _saving = false;
  @override
  void initState() {
    Usuario_Model c = widget._usuario_model;
    _idController =
        new TextEditingController(text: c.identificacion.toString());
    _nombreController = new TextEditingController(text: c.nombre);
    _apellidoController = new TextEditingController(text: c.apellidos);
    _contrasenaController = new TextEditingController(text: c.contrasena);
    _admiRegistraController = new TextEditingController(text: c.idAdmiRegistra);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Usuario"),
      ),
      body: ListView(
        children: [
          _crearInputId(),
          Divider(
            thickness: 1.5,
          ),
          _crearInputNombre(),
          Divider(
            thickness: 1.5,
          ),
          _crearInputApellido(),
          Divider(
            thickness: 1.5,
          ),
          _crearInputCOntrasena(),
          Divider(
            thickness: 1.5,
          ),
          _crearSwitch(),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _saving = true;
                });
                _editarUsuario();
              },
              child: Text("Editar Contacto"))
        ],
      ),
    );
  }

  //*********** IMPUT ID *******************/
  Widget _crearInputId() {
    return TextField(
      controller: _idController,
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Identificacion',
          helperText: 'Ingrese identificacion',
          icon: Icon(Icons.account_circle)),
    );
  }

//*********** IMPUT DEL NOMBRE *******************/
  Widget _crearInputNombre() {
    return TextField(
      controller: _nombreController,
      //autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre',
          helperText: 'Nombre sin apellidos',
          icon: Icon(Icons.account_circle)),
    );
  }

//*********** IMPUT DEL Apellido *******************/
  Widget _crearInputApellido() {
    return TextField(
      //autofocus: true,
      controller: _apellidoController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Apellidos',
          icon: Icon(Icons.account_circle)),
    );
  }

  //*********** IMPUT Contrasena *******************/
  Widget _crearInputCOntrasena() {
    return TextField(
      //autofocus: true,
      controller: _contrasenaController,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Contraseña',
          icon: Icon(Icons.password)),
    );
  }

  //*********** Switch del Esado *******************/
  Widget _crearSwitch() {
    return SwitchListTile(
      title: Text('Estado del usuario'),
      value: _activo,
      onChanged: (valor) {
        setState(() {
          _activo = valor;
        });
      },
    );
  }

  //*********** Metodo Pricipal CrearUsuario *******************/
  void _editarUsuario() async {
    var c = Usuario_Model(0, "", "", "", false, "admin");

    c
      ..identificacion = int.parse(_idController.text)
      ..nombre = _nombreController.text
      ..apellidos = _apellidoController.text
      ..contrasena = _contrasenaController.text
      ..estado = _activo
      ..idAdmiRegistra = "admin";

    if (await Usuario_Service.editUsuario(c)) {
      final snackBar = SnackBar(
        content: Text('Usuario Modificado con éxito'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, c);
    } else {
      final snackBar = SnackBar(
        content: Text('Error Modificando Usuario'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _saving = false;
      });
    }
  }
}
