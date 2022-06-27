import 'package:csbiblio/componentes/form_field_padrao.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final usuario = TextEditingController();
  final senha = TextEditingController();
  String verifica = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(right: 20, left: 20, top: 210),
        child: ListView(
          children: [
            Center(
              child: Text(
                "Biblioteca",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            FormFieldPadrao(
              controle: usuario,
              title: "Usuário",
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldPadrao(
              controle: senha,
              title: "Senha",
              obscure: true,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 55,
              child: ElevatedButton(
                onPressed: (){
                  /*Provider.of<AuthService>(context, listen: false)
                      .logar(usuario.text, senha.text)
                      .then((value) => {
                    Get.snackbar(
                        "Login de usuário", value.toString(),
                        backgroundColor: Colors.green.shade50)
                  });*/

                },
                child: Text("Entrar"),
              ),
            ),
            SizedBox(
              height: 180,
            ),

          ],
        ),
      ),
    );
  }
}
