
import 'package:flutter/material.dart';

class AutorListaView extends StatefulWidget {
  const AutorListaView({Key? key}) : super(key: key);

  @override
  _AutorListaViewState createState() => _AutorListaViewState();
}

class _AutorListaViewState extends State<AutorListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Autores"),
      ),
      body: Container(),
    );
  }
}
