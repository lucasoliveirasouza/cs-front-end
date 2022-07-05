import 'package:csbiblio/models/Usuario.dart';
import 'package:csbiblio/services/usuario_service.dart';
import 'package:csbiblio/views/auth/cadastrar_usuario.dart';
import 'package:csbiblio/views/auth/editar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ListaUsuariosView extends StatefulWidget {
  const ListaUsuariosView({Key? key}) : super(key: key);

  @override
  _ListaUsuariosViewState createState() => _ListaUsuariosViewState();
}

class _ListaUsuariosViewState extends State<ListaUsuariosView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuários"),
      ),
      body: Consumer<UsuarioService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.usuarios.length,
            itemBuilder: (BuildContext contexto, int usuario) {
              final List<Usuario> lista = repositorio.usuarios;
              final item = lista[usuario].username;
              return Dismissible(
                key: Key(item!),
                child: Card(
                  child: ListTile(
                    title: Text(lista[usuario].username!),
                    subtitle: Text(lista[usuario].email!),
                    trailing: Text(lista[usuario].id!.toString()),
                  ),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Deletar"),
                        content: Text("Deseja realmente deletar esse usuário? Essa ação não poderá ser desfeita e poderá trazer problemas"),
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
                onDismissed: (direction) {
                  Provider.of<UsuarioService>(context, listen: false)
                      .deletarUsuario(lista[usuario].id.toString());
                  Get.snackbar(
                    "Excluir usuário",
                    "Usuário ${lista[usuario].username} excluído",
                    backgroundColor: Colors.green.shade100,
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
          Get.to(() => CadastrarUsuarioView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
