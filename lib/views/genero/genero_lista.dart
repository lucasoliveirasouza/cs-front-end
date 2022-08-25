import 'package:csbiblio/models/Genero.dart';
import 'package:csbiblio/services/genero_service.dart';
import 'package:csbiblio/views/genero/genero_cadastrar.dart';
import 'package:csbiblio/views/genero/genero_editar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class GeneroListaView extends StatefulWidget {
  const GeneroListaView({Key? key}) : super(key: key);

  @override
  _GeneroListaViewState createState() => _GeneroListaViewState();
}

class _GeneroListaViewState extends State<GeneroListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gêneros"),
      ),
      body: Consumer<GeneroService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.generos.length,
            itemBuilder: (BuildContext contexto, int genero) {
              final List<Genero> lista = repositorio.generos;
              final item = lista[genero].nome;
              return Dismissible(
                key: Key(item ?? "teste"),
                child: Card(
                  child: ListTile(
                    title: Center(child: Text(lista[genero].nome ?? "")),
                    onTap: () {
                      Get.to(() => GeneroEditarView(genero: lista[genero]));
                    },
                  ),
                ),
                onDismissed: (direction) {
                  Provider.of<GeneroService>(context, listen: false)
                      .deletarGenero(lista[genero].id.toString())
                      .then((value) => {
                            Get.snackbar("Excluir genero", value.toString(),
                                backgroundColor: Colors.green.shade50)
                          });
                },
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Deletar"),
                        content: Text("Deseja realmente deletar esse genero?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text(
                                "Deletar",
                              )),
                        ],
                      );
                    },
                  );
                },
                background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment(-0.9, 0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => Container(),
            padding: EdgeInsets.all(16),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => GeneroCadastrarView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
