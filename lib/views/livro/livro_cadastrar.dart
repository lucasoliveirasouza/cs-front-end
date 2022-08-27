import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:flutter/material.dart';

class LivroCadastrarView extends StatefulWidget {
  const LivroCadastrarView({Key? key}) : super(key: key);

  @override
  State<LivroCadastrarView> createState() => _LivroCadastrarViewState();
}

class _LivroCadastrarViewState extends State<LivroCadastrarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar livro"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, top: 20, left: 20),
          child: ListView(
            children: [
              FormFieldPadrao(
                controle: nome,
                title: "Nome",
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: nome,
                title: "Nome",
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: nome,
                title: "Nome",
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: nome,
                title: "Nome",
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
