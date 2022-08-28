import 'package:csbiblio/componentes/dropdown_padrao.dart';
import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/models/Autor.dart';
import 'package:csbiblio/models/Editora.dart';
import 'package:csbiblio/models/Genero.dart';
import 'package:csbiblio/models/Livro.dart';
import 'package:csbiblio/services/autor_service.dart';
import 'package:csbiblio/services/editora_service.dart';
import 'package:csbiblio/services/genero_service.dart';
import 'package:csbiblio/services/livro_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LivroEditarView extends StatefulWidget {
  Livro livro;
  LivroEditarView({Key? key, required this.livro}) : super(key: key);

  @override
  State<LivroEditarView> createState() => _LivroEditarViewState();
}

class _LivroEditarViewState extends State<LivroEditarView> {
  final titulo = TextEditingController();
  final nomeSaga = TextEditingController();
  final edicao = TextEditingController();
  final anoPublicacao = TextEditingController();
  final codigo = TextEditingController();
  final quantidade = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<Genero> generos = [];
  Autor autor = Autor();
  Editora editora = Editora();
  String autorId = "";
  String editoraId = "";
  @override
  Widget build(BuildContext context) {
    titulo.text = widget.livro.titulo!;
    nomeSaga.text = widget.livro.nomeSaga!;
    edicao.text = widget.livro.edicao!;
    anoPublicacao.text = widget.livro.anoPublicacao!.toString();
    codigo.text = widget.livro.codigo!;
    quantidade.text = widget.livro.quantidade!.toString();
    List<Genero>? generos = widget.livro.genero;
    autorId = widget.livro.autor!.id!;
    editoraId = widget.livro.editora!.id!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Editar livro"),
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
              controle: titulo,
              title: "Título",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: nomeSaga,
              title: "Nome da saga",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: edicao,
              title: "Edição",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: anoPublicacao,
              title: "Ano de publicação",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: codigo,
              title: "Código",
            ),
            SizedBox(
              height: 15,
            ),
            FormFieldPadrao(
              controle: quantidade,
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
              nome: "editora",
              future: EditoraService().getAll(),
              onSelect: (value) {
                editoraId = value;
              },
              initialValue: editoraId,
              child: 'nome',
              value: 'id',
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  salvarLivro();
                },
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
    List<Genero>? generos = widget.livro.genero;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: generos?.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(generos![index].nome ?? "test"),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addGenero();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  salvarLivro() {
    Livro livro = Livro();
    livro.setTitulo(titulo.text);
    livro.setNomeSaga(nomeSaga.text);
    livro.setEdicao(edicao.text);
    livro.setAnoPublicacao(int.parse(anoPublicacao.text));
    livro.setCodigo(codigo.text);
    livro.setQuantidade(int.parse(quantidade.text));
    AutorService().getById(autorId).then((value) {
      setState(() {
        autor = value!;
      });
      EditoraService().getById(editoraId).then((value) {
        setState(() {
          editora = value!;
        });
        print(autor.nome);
        livro.setAutor(autor);
        livro.setEditora(editora);
        livro.setGenero(generos);

        Provider.of<LivroService>(context, listen: false)
            .cadastrarLivro(livro)
            .then((value) {
          if (value == "Cadastrado com sucesso") {
            Get.snackbar("Cadastro de editora", value.toString(),
                backgroundColor: Colors.green.shade100);
            Navigator.of(context).pop();
          } else {
            Get.snackbar("Erro ao cadastrar editora", value.toString(),
                backgroundColor: Colors.red.shade100);
          }
        });
      });
    });
  }

  addGenero() {
    String generoId = "";
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Selecione um gênero"),
          content: DropdownPadrao<Genero>(
            nome: "Genero",
            future: GeneroService().getAll(),
            onSelect: (value) {
              generoId = value;
            },
            initialValue: generoId,
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
                GeneroService().getById(generoId).then((value) => {
                      setState(() {
                        generos.add(value!);
                      })
                    });
                Navigator.of(context).pop(false);

                /* AuthService().logout();
                Get.to(() => LoginView());*/
              },
              child: Text(
                "Adicionar",
              ),
            ),
          ],
        );
      },
    );
  }
}
