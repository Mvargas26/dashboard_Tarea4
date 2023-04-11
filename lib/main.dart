import 'package:dashboard_api_2/screens/home.dart';
import 'package:dashboard_api_2/screens/modify_usuario.dart';
import 'package:dashboard_api_2/screens/usuario_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contactos',
      initialRoute: '/',
      routes: {
        '/': (_) => Home(),
        'form': (_) => Usuario_Form(),
      },
    );
  }
}
