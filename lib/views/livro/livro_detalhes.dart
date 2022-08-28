import 'package:csbiblio/models/Livro.dart';
import 'package:csbiblio/services/livro_service.dart';
import 'package:csbiblio/views/livro/livro_editar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LivroDetalhesView extends StatefulWidget {
  Livro livro;
  LivroDetalhesView({Key? key, required this.livro}) : super(key: key);

  @override
  State<LivroDetalhesView> createState() => _LivroDetalhesViewState();
}

class _LivroDetalhesViewState extends State<LivroDetalhesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        actions: [
          PopupMenuButton(
              elevation: 20,
              enabled: true,
              onSelected: (value) {
                if (value == "editar") {
                  Get.to(() => LivroEditarView(livro: widget.livro));
                } else if (value == "deletar") {
                  deletar();
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Editar",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          )
                        ],
                      ),
                      value: "editar",
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: Colors.grey.shade500,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Deletar",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                            ),
                          )
                        ],
                      ),
                      value: "deletar",
                    ),
                  ])
        ],
      ),
      body: Container(),
    );
  }

  deletar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deletar"),
          content: Text("Deseja realmente deletar esse editora?"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
                onPressed: () {
                  Provider.of<LivroService>(context, listen: false)
                      .deletarLivro(widget.livro.id.toString())
                      .then((value) => {
                            Get.snackbar("Excluir Livro", value.toString(),
                                backgroundColor: Colors.green.shade50)
                          });
                  Navigator.of(context).pop();
                  Get.back();
                },
                child: Text(
                  "Deletar",
                )),
          ],
        );
      },
    );
  }
}
