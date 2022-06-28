import 'package:csbiblio/views/auth/cadastrar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(() => CadastrarUsuarioView());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
