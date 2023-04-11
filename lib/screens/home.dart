import 'package:dashboard_api_2/Services/cliente_service.dart';
import 'package:dashboard_api_2/models/usuario_model.dart';
import 'package:dashboard_api_2/screens/modify_usuario.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //VARIABLES
  Future<List<Usuario_Model>?>? listadoClientes;
  bool _asynCall = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuarios"),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.pushNamed(context, 'form');

              if (result != null) {
                Usuario_Model? c = result as Usuario_Model?;
                print(c!.nombre);
                setState(() {
                  listadoClientes = Usuario_Service.getUsuarios();
                });
              }
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: createBody(),
    );
  }

  Widget createBody() {
    return FutureBuilder(
      future: listadoClientes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //entro aqui si hay datos
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              ModifyUsuario(snapshot.data![index])));
                },
                onLongPress: () {},
                title: Text(snapshot.data![index].nombre +
                    " " +
                    snapshot.data![index].apellidos),
                subtitle: Text(snapshot.data![index].estado == 0
                    ? "Deshabilitado"
                    : "Habilitado"),
                trailing: Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
              );
            },
          );
        } else {
          //entra aqui si no hay datos
          return Center(
            child: TextButton(
              onPressed: () async {
                setState(() {
                  _asynCall = true;
                });
                listadoClientes = Usuario_Service.getUsuarios();
                setState(() {
                  _asynCall = false;
                });
              },
              child: Text("Ver Usuarios"),
            ),
          );
        }
        //Mientras es una u otra muestra la ruedita
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}//fn class home
