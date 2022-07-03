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
              return Card(
                child: ListTile(
                  title: Text(lista[usuario].username!),
                  subtitle: Text(lista[usuario].email!),
                  trailing: Text(lista[usuario].id!.toString()),
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
