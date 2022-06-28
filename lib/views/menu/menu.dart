import 'package:csbiblio/services/auth_service.dart';
import 'package:csbiblio/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Center(
        child: Text('Lista de Livros'),
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
                  child: Icon(Icons.account_circle,size: 50,),
                ),
              ),
            ),
            Container(
              child: Divider(color: Colors.grey,),
            ),

            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Cadastro de Usuários'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.text_snippet_outlined),
              title: Text('Editoras'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.view_agenda),
              title: Text('Gêneros'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: IconButton(
                onPressed: (){
                  logout();
                },
                icon: Icon(Icons.exit_to_app,size: 40,),
              ),
            )
          ],
        ),
      ),
    );
  }
  logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sair"),
          content: const Text("Deseja realmente sair do aplicativo?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                AuthService().logout();
                Get.to(() => LoginView());
              },
              child: Text(
                "Sair",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

}
