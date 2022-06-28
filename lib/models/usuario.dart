class Usuario {
  late String _id;
  late String _nome;
  late String _email;

  Usuario(this._id, this._nome, this._email);

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }
}
