import 'package:csbiblio/componentes/dropdown_padrao.dart';
import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/models/Autor.dart';
import 'package:csbiblio/models/Editora.dart';
import 'package:csbiblio/models/Genero.dart';
import 'package:csbiblio/services/autor_service.dart';
import 'package:csbiblio/services/editora_service.dart';
import 'package:flutter/material.dart';

class LivroCadastrarView extends StatefulWidget {
  const LivroCadastrarView({Key? key}) : super(key: key);

  @override
  State<LivroCadastrarView> createState() => _LivroCadastrarViewState();
}

class _LivroCadastrarViewState extends State<LivroCadastrarView> {
  final nome = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late final List<Genero> generos;
  String autorId = "";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Cadastrar livro"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: "Formulário geral",
                ),
                Tab(
                  text: "Gêneros",
                ),
              ],
              indicatorColor: Colors.white,
            )),
        body: TabBarView(
          children: [
            Formulario(),
            Generos(),
          ],
        ),
      ),
    );
  }

  Widget Formulario() {
    return Form(
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
            FormFieldPadrao(
              controle: nome,
              title: "Nome da saga",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: nome,
              title: "Edição",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: nome,
              title: "Ano de publicação",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: nome,
              title: "Código",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: nome,
              title: "Quantidade",
            ),
            SizedBox(
              height: 15,
            ),
            DropdownPadrao<Autor>(
              nome: "Autor",
              future: AutorService().getAll(),
              onSelect: (value) {
                autorId = value;
              },
              initialValue: autorId,
              child: 'nome',
              value: 'id',
            ),
            SizedBox(
              height: 15,
            ),
            DropdownPadrao<Editora>(
              nome: "Autor",
              future: EditoraService().getAll(),
              onSelect: (value) {
                autorId = value;
              },
              initialValue: autorId,
              child: 'nome',
              value: 'id',
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Salvar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Generos() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addGenero();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  addGenero() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione um gênero"),
          content: DropdownPadrao<Autor>(
            nome: "Autor",
            future: AutorService().getAll(),
            onSelect: (value) {
              autorId = value;
            },
            initialValue: autorId,
            child: 'nome',
            value: 'id',
          ),
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
                Navigator.of(context).pop(false);
                /* AuthService().logout();
                Get.to(() => LoginView());*/
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
