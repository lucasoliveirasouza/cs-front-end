import 'package:flutter/material.dart';

class FormFieldPadrao extends StatelessWidget {

  TextEditingController controle;
  String title;
  TextInputType? tipo;
  bool? obscure;

  FormFieldPadrao({
    Key? key,
    required this.controle,
    required this.title,
    this.tipo,
    this.obscure
  }) : super(key: key);

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      keyboardType: tipo ?? TextInputType.text,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        label: Text(title),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            new Radius.circular(10.0),
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Campo vazio!";
        }
        return null;
      },
    );
  }
}