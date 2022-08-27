import 'package:flutter/material.dart';

class LivroCadastrarView extends StatefulWidget {
  const LivroCadastrarView({Key? key}) : super(key: key);

  @override
  State<LivroCadastrarView> createState() => _LivroCadastrarViewState();
}

class _LivroCadastrarViewState extends State<LivroCadastrarView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar livro"),
      ),
      body: Container(),
    );
  }
}
