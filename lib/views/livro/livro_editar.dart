import 'package:csbiblio/models/Livro.dart';
import 'package:flutter/material.dart';

class LivroEditarView extends StatefulWidget {
  Livro livro;
  LivroEditarView({Key? key, required this.livro}) : super(key: key);

  @override
  State<LivroEditarView> createState() => _LivroEditarViewState();
}

class _LivroEditarViewState extends State<LivroEditarView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
