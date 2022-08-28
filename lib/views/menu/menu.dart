import 'package:csbiblio/models/Livro.dart';
import 'package:csbiblio/services/auth_service.dart';
import 'package:csbiblio/services/livro_service.dart';
import 'package:csbiblio/views/auth/lista_usuarios.dart';
import 'package:csbiblio/views/auth/login.dart';
import 'package:csbiblio/views/autor/autor_lista.dart';
import 'package:csbiblio/views/editora/editora_lista.dart';
import 'package:csbiblio/views/genero/genero_lista.dart';
import 'package:csbiblio/views/livro/livro_cadastrar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livros")),
      body: Consumer<LivroService>(
        builder: (context, repositorio, child) {
          return ListView.separated(
            itemCount: repositorio.livros.length,
            itemBuilder: (BuildContext contexto, int livro) {
              final List<Livro> lista = repositorio.livros;
              final item = lista[livro].titulo;
              return Dismissible(
                key: Key(item ?? "teste"),
                child: Card(
                  child: ListTile(
                    title: Text(lista[livro].titulo ?? ""),
                    subtitle: Text(lista[livro].autor?.nome ?? ""),
                    trailing: Text(lista[livro].quantidade.toString()),
                    onTap: () {
                      //Get.to(() => EditoraEditarView(editora: lista[editora]));
                    },
                  ),
                ),
                onDismissed: (direction) {
                  /*Provider.of<LivroService>(context, listen: false)
                      .deletarEditora(lista[editora].id.toString())
                      .then((value) => {
                            Get.snackbar("Excluir editora", value.toString(),
                                backgroundColor: Colors.green.shade50)
                          });*/
                },
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
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
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 65,
              child: ListTile(
                title: Text(
                  'Administrador',
                  style: TextStyle(fontSize: 20),
                ),
                leading: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.account_circle,
                    size: 50,
                  ),
                ),
              ),
            ),
            Container(
              child: Divider(
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Cadastro de Usuários'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.to(() => ListaUsuariosView());
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Livros'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Autores'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.to(() => AutorListaView());
              },
            ),
            ListTile(
              leading: Icon(Icons.text_snippet_outlined),
              title: Text('Editoras'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.to(() => EditoraListaView());
              },
            ),
            ListTile(
              leading: Icon(Icons.view_agenda),
              title: Text('Gêneros'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Get.to(() => GeneroListaView());
              },
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: IconButton(
                onPressed: () {
                  logout();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  size: 40,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => LivroCadastrarView());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Sair"),
          content: Text("Deseja realmente sair do aplicativo?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "Cancelar",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                AuthService().logout();
                Get.to(() => LoginView());
              },
              child: Text(
                "Sair",
              ),
            ),
          ],
        );
      },
    );
  }
}
