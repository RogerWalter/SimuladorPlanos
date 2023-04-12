class ItemMostrar{
  String _icone = "";
  String _info_1 = "";
  String _info_2 = "";
  String _info_3 = "";
  String _info_4 = "";
  String _grupo = "";

  ItemMostrar.vazio();

  ItemMostrar(this._icone, this._info_1, this._info_2, this._info_3,
      this._info_4, this._grupo);

  String get icone => _icone;

  set icone(String value) {
    _icone = value;
  }

  String get info_1 => _info_1;

  String get info_4 => _info_4;

  set info_4(String value) {
    _info_4 = value;
  }

  String get info_3 => _info_3;

  set info_3(String value) {
    _info_3 = value;
  }

  String get info_2 => _info_2;

  set info_2(String value) {
    _info_2 = value;
  }

  set info_1(String value) {
    _info_1 = value;
  }

  String get grupo => _grupo;

  set grupo(String value) {
    _grupo = value;
  }
}
