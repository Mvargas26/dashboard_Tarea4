import 'dart:convert';

extension Desencriptando on String {
  String desencriptar() {
    String result = '';
    List<int> mostrarBytes = base64.decode(this);
    result = utf8.decode(mostrarBytes);
    return result;
  }
}
