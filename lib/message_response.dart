import 'package:flutter/material.dart';

messageResponse(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Atencion"),
            content: Text(mensaje),
          ));
}
