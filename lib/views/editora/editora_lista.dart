
import 'package:csbiblio/models/Editora.dart';
import 'package:csbiblio/services/editora_service.dart';
import 'package:csbiblio/views/editora/editora_cadastrar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditoraListaView extends StatefulWidget {
  const EditoraListaView({Key? key}) : super(key: key);

  @override
  _EditoraListaViewState createState() => _EditoraListaViewState();
}

class _EditoraListaViewState extends State<EditoraListaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editoras"),
      ),
      body: Consumer<EditoraService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.editoras.length,
            itemBuilder: (BuildContext contexto, int editora) {
              final List<Editora> lista = repositorio.editoras;
              final item = lista[editora].nome;
              return Dismissible(
                key: Key(item ?? "teste"),
                child: Card(
                  child: ListTile(
                    title: Center(child: Text(lista[editora].nome ?? "")),
                    onTap: (){
                      //Get.to(() => EditoraEditarView(editora: lista[editora]));
                    },

                  ),
                ),
                onDismissed: (direction) {
                  Provider.of<EditoraService>(context, listen: false)
                      .deletarEditora(lista[editora].id.toString()).then((value) => {
                    Get.snackbar(
                        "Excluir editora", value.toString(),
                        backgroundColor: Colors.green.shade50)
                  });
                },
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Deletar"),
                        content: Text(
                            "Deseja realmente deletar esse editora?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text("Cancelar",style: TextStyle(color: Colors.red),),
                          ),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text("Deletar",)),

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
        onPressed: (){
          Get.to(() => EditoraCadastrarView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
