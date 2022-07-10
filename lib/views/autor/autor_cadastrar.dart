import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/services/autor_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AutorCadastrarView extends StatefulWidget {
  AutorCadastrarView({Key? key}) : super(key: key);

  @override
  _AutorCadastrarViewState createState() => _AutorCadastrarViewState();
}

class _AutorCadastrarViewState extends State<AutorCadastrarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar autor"),
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
              Container(
                height: 50,
                padding: EdgeInsets.only(right: 50, left: 50),
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Provider.of<AutorService>(context, listen: false)
                          .cadastrarAutor(nome.text)
                          .then((value) => {
                        Get.snackbar(
                            "Cadastro de autor", value.toString(),
                            backgroundColor: Colors.green.shade50)
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    "Salvar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
