import 'package:csbiblio/models/IModel.dart';
import 'package:flutter/material.dart';

class DropdownPadrao<T extends IModel> extends StatefulWidget {
  Future<List<T?>?> future;
  String initialValue;
  String child;
  String nome;
  List<String>? childList = [];
  String value;
  ValueChanged? onTap;
  Function(String)? onSelect;

  DropdownPadrao(
      {Key? key,
      required this.future,
      required this.initialValue,
      required this.child,
      required this.value,
      required this.nome,
      this.onSelect,
      this.onTap})
      : super(key: key);

  @override
  State<DropdownPadrao> createState() => _DropdownPadraoState<T>();
}

class _DropdownPadraoState<T extends IModel> extends State<DropdownPadrao> {
  @override
  dynamic get(String propriedade) {}

  Widget build(BuildContext context) {
    return FutureBuilder<List<T?>?>(
      future: widget.future as Future<List<T?>?>,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Sem dados');
        }
        if (snapshot.hasData) {
          if (widget.initialValue.isEmpty) {
            if (snapshot.data!.length > 0) {
              widget.initialValue = snapshot.data![0]?.toJson()[widget.value];
            } else {
              return Text('Não encontramos nenhum registro');
            }
          }
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
                labelText: widget.nome,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(new Radius.circular(10)),
                )),
            icon: Icon(null),
            value: widget.initialValue,
            items: snapshot.data?.map((e) {
              return DropdownMenuItem<String>(
                child: Text(e?.toJson()[widget.child]),
                value: e?.toJson()[widget.value],
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                widget.initialValue = value!;
                widget.onSelect!(value);
              });
            },
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
