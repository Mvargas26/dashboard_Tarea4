import 'package:dashboard_api_2/message_response.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../Services/cliente_service.dart';
import '../models/usuario_model.dart';

class Usuario_Form extends StatefulWidget {
  @override
  State<Usuario_Form> createState() => _Usuario_FormState();
}

class _Usuario_FormState extends State<Usuario_Form> {
  //VARIABLES
  bool _activo = false;
  final _idController = new TextEditingController();
  final _nombreController = new TextEditingController();
  final _apellidoController = new TextEditingController();
  final _contrasenaController = new TextEditingController();
  final _admiRegistraController = new TextEditingController();
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingrese los datos del cliente"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _saving = true;
              });
              _crearUsuario();
              //messageResponse(context, "Usuario Creado");
            },
            icon: Icon(
              Icons.save_outlined,
            ),
          )
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
          ],
        ),
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
  void _crearUsuario() async {
    var c = Usuario_Model(0, "", "", "", false, "admin");

    c
      ..identificacion = int.parse(_idController.text)
      ..nombre = _nombreController.text
      ..apellidos = _apellidoController.text
      ..contrasena = _contrasenaController.text
      ..estado = _activo
      ..idAdmiRegistra = "admin";

    if (await Usuario_Service.createUsuario(c)) {
      final snackBar = SnackBar(
        content: Text('Usuario creado con éxito'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context, c);
    } else {
      final snackBar = SnackBar(
        content: Text('Error creando Usuario'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _saving = false;
      });
    }
  }
}//FIN CLASS
