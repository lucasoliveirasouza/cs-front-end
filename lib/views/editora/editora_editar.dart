import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/models/Editora.dart';
import 'package:csbiblio/services/editora_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditoraEditarView extends StatefulWidget {
  Editora editora;
  EditoraEditarView({Key? key, required this.editora}) : super(key: key);

  @override
  _EditoraEditarViewState createState() => _EditoraEditarViewState();
}

class _EditoraEditarViewState extends State<EditoraEditarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nome.text = widget.editora.nome!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar editora"),
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
                      Editora editora =  Editora();
                      editora.setNome(nome.text);
                      editora.setId(widget.editora.id!);
                      Provider.of<EditoraService>(context, listen: false)
                          .editarEditora(editora)
                          .then((value){
                        if (value == "Editado com sucesso") {
                          Get.snackbar("Edição de editora", value.toString(),
                              backgroundColor: Colors.green.shade100);
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar(
                              "Erro ao editar editora", value.toString(),
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
