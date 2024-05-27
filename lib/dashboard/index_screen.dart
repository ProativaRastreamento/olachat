import 'package:flutter/material.dart';
import 'dash_tickets_filas.dart';

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Painel de Controle'),
      ),
      body: DashTicketsFilas(),
    );
  }
}
