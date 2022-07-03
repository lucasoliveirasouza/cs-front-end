import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:csbiblio/models/Usuario.dart';
import 'package:csbiblio/services/usuario_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditarUsuarioView extends StatefulWidget {
  Usuario usuario;
  EditarUsuarioView({Key? key,required this.usuario}) : super(key: key);

  @override
  _EditarUsuarioViewState createState() => _EditarUsuarioViewState();
}

class _EditarUsuarioViewState extends State<EditarUsuarioView> {
  final usuario = TextEditingController();
  final email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String funcao = 'Usuário';
  List<String> funcoes = ["Usuário", "Moderador", "Administrador"];

  @override
  Widget build(BuildContext context) {
    usuario.text = widget.usuario.username!;
    email.text = widget.usuario.email!;
    if(widget.usuario.role!.name == "ROLE_USER"){
      funcao = "Usuário";
    }else if(widget.usuario.role!.name == "ROLE_ADMIN"){
      funcao = "Administrador";
    }else{
      funcao = "Moderador";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar usuário"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: ListView(
            children: [
              FormFieldPadrao(
                controle: usuario,
                title: "Usuário",
              ),
              SizedBox(
                height: 15,
              ),
              FormFieldPadrao(
                controle: email,
                title: "Email",
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                    label: Text("Função"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(new Radius.circular(10)),
                    )),
                value: funcao,
                icon: Icon(null),
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    funcao = newValue!;
                  });
                },
                items: funcoes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                        Provider.of<UsuarioService>(context, listen: false)
                            .registrarUsuario(
                            usuario.text, email.text, "senha.text", funcao)
                            .then((value) {
                          if (value == "User registered successfully!") {
                            Get.snackbar(
                                "Cadastro de usuário", value.toString(),
                                backgroundColor: Colors.green.shade100);
                            Navigator.of(context).pop();
                          } else {
                            Get.snackbar(
                                "Erro ao cadastrar usuário", value.toString(),
                                backgroundColor: Colors.red.shade100);
                          }
                        });

                    }
                  },
                  child: Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
