class Produto{
  int _id = 0;
  String _descricao = "";
  String _icone = "";
  String _icone_branco = "";
  String _icone_azul_claro = "";
  String _imagem = "";
  int _tipo_cliente = 0; //0 - AMBOS | 1 - PESSOA FÍSICA | 2 - PESSOA JURÍDICA

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get descricao => _descricao;

  String get icone => _icone;

  set icone(String value) {
    _icone = value;
  }

  set descricao(String value) {
    _descricao = value;
  }


  Produto(this._id, this._descricao, this._icone, this._icone_branco, this._icone_azul_claro, this._imagem, this._tipo_cliente);

  Produto.vazio();

  String get icone_branco => _icone_branco;

  set icone_branco(String value) {
    _icone_branco = value;
  }

  int get tipo_cliente => _tipo_cliente;

  set tipo_cliente(int value) {
    _tipo_cliente = value;
  }

  String get icone_azul_claro => _icone_azul_claro;

  set icone_azul_claro(String value) {
    _icone_azul_claro = value;
  }
}