import 'package:csbiblio/componentes/row_table.dart';
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
  String generos = "";
  @override
  Widget build(BuildContext context) {
    widget.livro.genero!.forEach((element) {
      generos += element.nome! + "\n";
    });
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
      body: Container(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 20,
        ),
        child: ListView(
          children: [
            Center(
              child: Text(
                widget.livro.titulo!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RowTable(
              title: "Saga:",
              valor: widget.livro.nomeSaga!,
            ),
            SizedBox(
              height: 5,
            ),
            RowTable(
              title: "Edição:",
              valor: widget.livro.edicao!,
            ),
            SizedBox(
              height: 5,
            ),
            RowTable(
              title: "Ano:",
              valor: widget.livro.anoPublicacao!.toString(),
            ),
            SizedBox(
              height: 5,
            ),
            RowTable(
              title: "Código:",
              valor: widget.livro.codigo!,
            ),
            SizedBox(
              height: 5,
            ),
            RowTable(
              title: "Quantidade:",
              valor: widget.livro.quantidade!.toString(),
            ),
            SizedBox(
              height: 5,
            ),
            RowTable(
              title: "Autor:",
              valor: widget.livro.autor!.nome!,
            ),
            SizedBox(
              height: 5,
            ),
            RowTable(
              title: "Editora:",
              valor: widget.livro.editora!.nome!,
            ),
            SizedBox(
              height: 5,
            ),
            Table(
              children: [
                TableRow(children: [
                  Container(
                    padding: EdgeInsets.only(right: 5, top: 5, bottom: 5),
                    child: Text(
                      "Gêneros",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                      ),
                    ),
                    color: Colors.green.shade100,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                    child: Text(
                      generos,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                  )
                ]),
              ],
            )
          ],
        ),
      ),
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
