import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/models/Genero.dart';
import 'package:csbiblio/services/genero_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class GeneroEditarView extends StatefulWidget {
  Genero genero;
  GeneroEditarView({Key? key, required this.genero}) : super(key: key);

  @override
  _GeneroEditarViewState createState() => _GeneroEditarViewState();
}

class _GeneroEditarViewState extends State<GeneroEditarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    nome.text = widget.genero.nome!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar genero"),
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
                      Genero genero = Genero();
                      genero.setNome(nome.text);
                      genero.setId(widget.genero.id!);
                      Provider.of<GeneroService>(context, listen: false)
                          .editarGenero(genero)
                          .then((value) {
                        if (value == "Editado com sucesso") {
                          Get.snackbar("Edição de genero", value.toString(),
                              backgroundColor: Colors.green.shade100);
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar(
                              "Erro ao editar gênero", value.toString(),
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
