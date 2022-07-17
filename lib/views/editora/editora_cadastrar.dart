import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/services/editora_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditoraCadastrarView extends StatefulWidget {
  EditoraCadastrarView({Key? key}) : super(key: key);

  @override
  _EditoraCadastrarViewState createState() => _EditoraCadastrarViewState();
}

class _EditoraCadastrarViewState extends State<EditoraCadastrarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar editora"),
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
                      Provider.of<EditoraService>(context, listen: false)
                          .cadastrarEditora(nome.text)
                          .then((value) {

                        if (value == "Cadatrado com sucesso") {
                          Get.snackbar(
                              "Cadastro de editora", value.toString(),
                              backgroundColor: Colors.green.shade100);
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar(
                              "Erro ao cadastrar editora", value.toString(),
                              backgroundColor: Colors.red.shade100);
                        }
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
